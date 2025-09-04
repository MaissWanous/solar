const express = require("express");
const router = express.Router();
const userService = require("../service/userService");
const authService = require("../service/authService");
const jwtService = require("../service/jwtService");

router.use(express.json());

// In-memory temporary store
const tempStore = {};

/**
 * User Signup - Step 1: Register and send verification code
 */
router.post("/signup", async (req, res) => {
  const { Fname, Lname, phone, email, password, country, type } = req.body;

  try {
    // Check user data and send code
    const  userData  = await userService.prepareSignup({
      Fname,
      Lname,
      phone,
      email,
      password,
      country,
      type,
    });

    // Store temporarily
    tempStore[email] = { userData: userData};

    res
      .status(200)
      .json({
        message:
          "Signup initiated. Check your email for the verification code.",
      });
  } catch (error) {
    console.error("Signup error:", error);
    res.status(400).json({ error: error.message });
  }
});

/**
 * Signup - Step 2: Verify code and complete registration
 */
router.post("/verify", async (req, res) => {
  const { email, checkCode } = req.body;

  try {
    const { rawPassword } = await userService.completeSignup(
      email,
      checkCode
    );
    const token = await authService.login(email, rawPassword); // use original password
    res.status(201).json({ message: "Signup completed successfully.", token });
  } catch (error) {
    console.error("Verification error:", error);
    res.status(400).json({ error: error.message });
  }
});
/**
 * upload profile picture
 */
router.post("/upload-profile-pic", async (req, res) => {
  try {
    const authHeader = req.headers.authorization;
    if (!authHeader?.startsWith("Bearer ")) {
      return res.status(401).json({ error: "Missing or malformed token." });
    }

    const token = authHeader.split(" ")[1];
    const decoded = jwtService.verifyToken(token);
    const userId = decoded.userId;

    const imageFile = req.files?.profilePic;
    console.log("req.files:", req.files);
    console.log("req.body:", req.body);

    const dbPath = await userService.uploadProfilePicture(userId, imageFile);

    res
      .status(200)
      .json({
        message: "Profile picture uploaded successfully.",
        path: dbPath,
      });
  } catch (err) {
    console.error("Upload error:", err);
    res.status(400).json({ error: err.message });
  }
});
/**
 * Login
 */
router.post("/login", async (req, res) => {
  const { email, password } = req.body;
  try {
    const Check = await userService.login({ email, password })
    if (Check) {
      const token = await authService.login(email, password);
      if (token.token === 0) {
        return res.status(401).json({ error: token.message });
      }

      res.status(200).json({ token: token.token, message: token.message });

    }
  } catch (error) {
    console.error("Login error:", error);
    res.status(500).json({ error: error.message || "Failed to log in." });
  }
});

/**
 * Forget Password - Send reset code
 */
router.post("/forget-password", async (req, res) => {
  const { email } = req.body;

  try {
    const user = await userService.checkEmailExisting(email);
    if (!user) return res.status(404).json({ error: "Email not found." });
console.log("ffffffff")
    const code = await userService.sendCode(email);
 console.log(code)
    tempStore[email] = { resetCode: code };
    console.log(code)

    res.status(200).json({ message: "Reset code sent to your email." });
  } catch (error) {
    console.error("Forgot password error:", error);
    res.status(500).json({ error: "Failed to send reset code." });
  }
});

/**
 * Reset Password
 */
router.post("/reset-password", async (req, res) => {
  const { email, newPassword, resetCode } = req.body;

  try {
    const entry = tempStore[email];
    if (!entry || parseInt(resetCode) !== entry.resetCode) {
      return res.status(400).json({ error: "Invalid or expired reset code." });
    }

    await userService.updatePassword(email, newPassword);
    delete tempStore[email];

    res.status(200).json({ message: "Password updated successfully." });
  } catch (error) {
    console.error("Reset password error:", error);
    res.status(500).json({ error: "Failed to reset password." });
  }
});

/**
 * Get User Profile (Protected)
 */
router.get("/profile", async (req, res) => {
  const authHeader = req.headers.authorization;
  if (!authHeader?.startsWith("Bearer ")) {
    return res.status(401).json({ error: "Missing or malformed token." });
  }

  const token = authHeader.split(" ")[1];

  try {
    const decoded = jwtService.verifyToken(token);
    const user = await userService.findById(decoded.userId);
    console.log(user)
    if (!user) return res.status(404).json({ error: "User not found." });

    res.status(200).json({ user });
  } catch (error) {
    console.error("Profile error:", error);
    res.status(401).json({ error: "Unauthorized access." });
  }
});

router.get("/technical", async (req, res) => {
 

  try {

    const user = await userService.getTechnicalAccounts();

    if (!user) return res.status(404).json({ error: "User not found." });

    res.status(200).json({ user });
  } catch (error) {
    console.error("Profile error:", error);
    res.status(401).json({ error: "Unauthorized access." });
  }
});
router.post("/addLinks", async (req, res) => {
  const { linkInfo } = req.body;
  const authHeader = req.headers.authorization;
  if (!authHeader?.startsWith("Bearer ")) {
    return res.status(401).json({ error: "Missing or malformed token." });
  }

  const token = authHeader.split(" ")[1];
  try {
    const decoded = jwtService.verifyToken(token);
    const user = await userService.addLink(decoded.userId, linkInfo);

    if (!user) return res.status(404).json({ error: "User not found." });

    res.status(200).json({ user });
  } catch (error) {
    console.error("Profile error:", error);
    res.status(401).json({ error: "Unauthorized access." });
  }
});
// get refresh token
router.get("/refresh", async (req, res) => {

  const authHeader = req.headers.authorization;
  if (!authHeader?.startsWith("Bearer ")) {
    return res.status(401).json({ error: "Missing or malformed token." });
  }

  try {
    const token = authHeader.split(" ")[1];
    const decoded = jwtService.verifyToken(token);
    const newtoken = await authService.refreshToken(decoded.userId);
    const user = await userService.findById(decoded.userId);

    if (!user) return res.status(404).json({ error: "User not found." });

    res.status(200).json({
      token: newtoken.token,
      message: newtoken.message
    });

  } catch (error) {
    console.error("Profile error:", error);
    res.status(401).json({ error: "Unauthorized access." });
  }
});
module.exports = router;
