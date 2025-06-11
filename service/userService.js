const { account } = require("../models");
const bcrypt = require("bcryptjs");
const nodemailer = require("nodemailer");

const userService = {
  async checkEmailExisting(email) {
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

    if (!emailRegex.test(email.toLowerCase())) {
      throw new Error("Invalid email format. Please enter a valid email address.");
    }

    const existingUser = await account.findOne({ where: { email } });
    console.log("Existing user:", existingUser);
    return existingUser || false;
  },

  async findById(ID) {
    const existingUser = await account.findOne({ where: {accountId: ID } });
    return existingUser || false;
  },

  async sendCode(email) {
    const confirmCode = 0; // You can randomize this for production
    console.log("Generated check code:", confirmCode);

    try {
      const transporter = nodemailer.createTransport({
        host: "smtp.elasticemail.com",
        port: 2525,
        auth: {
          user: "whiteocjd@gmail.com",
          pass: "70028532E494746FB9CD5CDA7519A033E123", // ⚠️ Do NOT expose this in production!
        },
      });

      const info = await transporter.sendMail({
        from: "whiteocjd@gmail.com",
        to: email,
        subject: "Confirm your email",
        text: `To confirm your password, use this code: ${confirmCode}`,
        html: `To confirm, please use the following One Time code: <strong>${confirmCode}</strong>`,
      });

      console.log("Email sent:", info.messageId);
    } catch (error) {
      console.error("Error sending email:", error);
    }

    return confirmCode;
  },

  async checkUser(userData) {
    if (!userData.email || !userData.password) {
      throw new Error("Missing required fields");
    }

    const hashedPassword = await bcrypt.hash(userData.password, 10);
    userData.password = hashedPassword;

    if (userData.phone) {
      userData.phone = parseInt(userData.phone);
    }

    try {
      const emailExists = await this.checkEmailExisting(userData.email);
      if (emailExists) throw new Error("Email is already existing");

      const checkCode = await this.sendCode(userData.email);
      return { checkCode, userData };
    } catch (error) {
      throw error;
    }
  },

  async checkLogIn(userData) {
    if (!userData.email || !userData.password) {
      throw new Error("Missing required fields");
    }

    const email = userData.email;
    try {
      const existingUser = await this.checkEmailExisting(email);
      if (!existingUser) {
        return { message: 'user not found' }; // user not found
      }

      const isMatch = await bcrypt.compare(userData.password, existingUser.password);
      if (!isMatch) {
        return { message: 'wrong password'}; // wrong password
      }

      return { existingUser, message: 1 }; // login success
    } catch (error) {
      throw error;
    }
  },

  async addUser(data) {
    try {
      console.log("Creating user:", data);
      const newUser = await account.create(data); 
      return newUser;
    } catch (err) {
      console.error("Error creating user:", err);
      throw err;
    }
  },

  async updatePassword(email, newPassword) {
    try {
      const existingUser = await this.checkEmailExisting(email);
      if (!existingUser) throw new Error("User not found");

      const hashedPassword = await bcrypt.hash(newPassword, 10);
      existingUser.password = hashedPassword;
      await existingUser.save();

      return { message: "Password updated successfully." };
    } catch (error) {
      throw new Error("Error updating password: " + error.message);
    }
  },
};

module.exports = userService;
