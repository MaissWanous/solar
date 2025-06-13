// service/userService.js
const { account, shop } = require("../models");
const bcrypt = require("bcryptjs");
const nodemailer = require("nodemailer");

const pendingUsers = {}; // In-memory temp store (consider Redis in production)

const generateRandomCode = () => Math.floor(100000 + Math.random() * 900000);

const userService = {
  async checkEmailExisting(email) {
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailRegex.test(email.toLowerCase())) {
      throw new Error("Invalid email format.");
    }
    return await account.findOne({ where: { email } });
  },

  async findById(id) {
    return await account.findByPk(id);
  },

  async sendCode(email) {
    const confirmCode = 0;
    // generateRandomCode();

    try {
      const transporter = nodemailer.createTransport({
        host: "smtp.elasticemail.com",
        port: 2525,
        auth: {
           user: "whiteocjd@gmail.com",
           pass: "70028532E494746FB9CD5CDA7519A033E123",
        },
      });

      await transporter.sendMail({
        from: "whiteocjd@gmail.com",
        to: email,
        subject: "Email Confirmation",
        html: `Use this verification code: <strong>${confirmCode}</strong>`,
      });
    } catch (error) {
      console.error("Email send failed:", error);
      throw new Error("Email sending failed");
    }

    return confirmCode;
  },

 async prepareSignup(userData) {
    const existing = await account.findOne({ where: { email: userData.email } });
    if (existing) throw new Error("Email already exists.");

    const hashedPassword = await bcrypt.hash(userData.password, 10);
    const checkCode = 0;
    // Math.floor(100000 + Math.random() * 900000); // 6-digit code

    // Save plain password for login after signup
    pendingUsers[userData.email] = {
      checkCode,
      userData: {
        ...userData,
        password: hashedPassword
      },
      rawPassword: userData.password
    };

    await sendCode(userData.email, checkCode); // You must have sendCode()

    return { message: "Check your email for the verification code." };
  },

  async completeSignup(email, inputCode) {
    const entry = pendingUsers[email];
    if (!entry || entry.checkCode !== parseInt(inputCode)) {
      throw new Error("Invalid or expired verification code.");
    }

    const createdUser = await account.create(entry.userData);
    if (entry.userData.type === "shopKeeper") {
      await shop.create({ shopKeeperId: createdUser.accountId });
    }

    delete pendingUsers[email];
    return { createdUser, rawPassword: entry.rawPassword };
  },
  async login({ email, password }) {
    const user = await this.checkEmailExisting(email);
    let message;
    if (!user) message="User not found";

    const valid = await bcrypt.compare(password, user.password);
    if (!valid) message="Incorrect password";

    return {user,message};
  },

  async updatePassword(email, newPassword) {
    const user = await this.checkEmailExisting(email);
    if (!user) throw new Error("User not found");

    user.password = await bcrypt.hash(newPassword, 10);
    await user.save();
    return true;
  },
};

module.exports = userService;
