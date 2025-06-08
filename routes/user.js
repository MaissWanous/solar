const express = require("express");
const userService = require("../service/userService");
const authService = require("../service/authService");
const jwtService = require("../service/jwtService");

const app = express();
const router = express.Router();

app.use(express.json());

let checkCode = 0;
let userData; 
let emailForget;
router.post("/signup", async (req, res) => {
  const { Fname,Lname, phone, email, password,country ,type} = req.body;

  try {
    const data = await userService.checkUser({
      Fname,Lname, phone, email, password,country ,type
    });
    userData = data.userData;
   
    res.status(200).json({ message: "Signup successful, check your code." });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Invalid data" });
  }
});

router.post("/checkCode", async (req, res) => {
  const userCode = parseInt(req.body.checkCode);
  //   const userData = req.session.userData;
  try {
    console.log(checkCode == userCode);

    if (userCode == checkCode) {
      if (userData) {
        await userService.addUser(userData);
        const token = await authService.login(
          userData.email,
          userData.password
        );
        res.json({ token });
      }
      res.status(200).json({ message: "Check code." });
    } else {
      res.status(400).json({ error: "Invalid check code." });
    }
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "An error occurred while adding the user." });
  }
});
router.post("/logIn", async function (req, res) {
  const { email, password } = req.body;
  try {
    const token = await authService.login(email, password);
    res.status(200).json({ token: token.token, message: token.message });
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Invalid data" });
  }
});

router.post("/forgetPassword", async function (req, res) {
  emailForget = req.body.email;
  try {
    const data = await userService.checkEmailExisting(emailForget);
    if (data) {
      checkCode = await userService.sendCode(emailForget);
      console.log(checkCode);
      res.status(200).send("Email send");
    }
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Invalid data" });
  }
});
router.post("/resetPass", async function (req, res) {
  const { password } = req.body;
  try {
    const updatePass = await userService.updatePassword(emailForget, password);
    console.log(updatePass);
    res.status(200).send("reset password");
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: "Invalid data" });
  }
});

router.get("/profile", async (req, res) => {
  const authHeader = req.headers.authorization;
  console.log(authHeader)
  if (!authHeader) {
    return res.status(401).json({
      message: "Unauthorized: Missing Authorization header",
    });
  }
  const token = authHeader.split(" ")[1];
  console.log(token)
  if (!token) {
    return res
      .status(401)
      .json({ message: "Unauthorized: Invalid token format" });
  }
  try {
    const decoded = jwtService.verifyToken(token); // تحقق من صحة Refresh Token

    const user = await userService.findById(decoded.userId); // ابحث عن المستخدم بناءً على معرف المستخدم في التوكن

    if (!user) return res.status(403).json({ message: "Forbidden" });

    res.json({ user: user });
  } catch (error) {
    console.error(error);
    res.status(401).json({ message: "Unauthorized" });
  }
})


module.exports = router;
