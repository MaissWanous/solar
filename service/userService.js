const { account } = require("../models");
const bcrypt = require("bcryptjs");
const nodemailer = require("nodemailer");
const { use } = require("../routes/user");
const userService = {
  async checkEmailExisting(email) {
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

    if (!emailRegex.test(email.toLowerCase())) {
      throw new Error(
        "Invalid email format. Please enter a valid email address."
      );
    }
    // Check for existing user with the same email
    const existingUser = await account.findOne({ where: { email } });
    if (existingUser) {
      return existingUser;
    } else {
      return false;
    }
  },
  async findById(ID) {
    const existingUser = await account.findOne({ where: { ID } });
    if (existingUser) {
      return existingUser;
    } else {
      return false;
    }
  },

  async sendCode(email) {
    const confirmCode = Math.floor(1000 + Math.random() * 9000).toString(); // Generate a random 4-digit number
    try {
      const transporter = nodemailer.createTransport({
        host: "smtp.elasticemail.com",
        port: 2525,
        auth: {
          user: "whiteocjd@gmail.com",
          pass: "70028532E494746FB9CD5CDA7519A033E123",
        },
      });

      const info = await transporter.sendMail({
        from: "whiteocjd@gmail.com",
        to: email,
        subject: "confirm your email ",
        text: "To confirm your password, please use the following One Time code:",
        html: `To confirm, please use the following One Time code <strong>${confirmCode}</strong>`,
      });
      console.log("Message sent:", info.messageId);
    } catch (error) {
      console.error("Error sending email:", error);
    }
    return confirmCode;
  },
  async checkUser(userData) {
    if (
      !userData.phone ||
      !userData.email ||
      !userData.password
    ) {
      throw new Error("Missing required fields");
    }

    // password encryption
    const hashedPassword = await bcrypt.hash(userData.password, 10);
    userData.password = hashedPassword;
    userData.phone = parseInt(userData.phone);

    try {
      if (await this.checkEmailExisting(userData.email))
        throw new Error("Email is already existing");
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
    email = userData.email;
    try {
      // Check for existing user with the same email
      const existingUser = await this.checkEmailExisting(email);
         
      if (!existingUser) {
        return { message: -1 };
      }
      console.log(userData.password+"oooooooo")
      console.log(existingUser.password+"eeeeeee")
      const isMatch = await bcrypt.compare(
        userData.password,
        existingUser.password
      );
      
      
   
      console.log(isMatch+"pppppppppppppppp")
      if (!isMatch) {
        return { message: 0 };
      }
      return { existingUser, message: 1 };
    } catch (error) {
      throw error;
    }
  },
  async addUser(data) {
    try {
      const newUser = account.create(data);
      return newUser;
    } catch (err) {
      throw err;
    }
  },
  async updatePassword(email, newPassword) {
    try {
      const existingUser = await this.checkEmailExisting(email);
      const hashedPassword = await bcrypt.hash(newPassword, 10);
      console.log(newPassword);
      if (existingUser) {
        existingUser.password = hashedPassword;
        await existingUser.save();
        return { message: "Password updated successfully." };
      } else throw new Error("User not found");
    } catch (error) {
      throw new Error("Error updating password: " + error.message);
    }
  },

}

module.exports = userService;
