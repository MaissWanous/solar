// service/userService.js
const { links,account, shop } = require("../models");
const bcrypt = require("bcryptjs");
const nodemailer = require("nodemailer");
const path = require('path');
const fs = require('fs');

const pendingUsers = {}; // In-memory temp store (consider Redis in production)

const generateRandomCode = () => Math.floor(100000 + Math.random() * 900000);

const userService = {
  async checkEmailExisting(email) {
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailRegex.test(email)) {
      throw new Error("Invalid email format.");
    }
    return await account.findOne({ where: { email:email } });
  },

  async findById(id) {
    return await account.findByPk(id);
  },

  async sendCode(email) {
       const checkCode = 0;
    // Math.floor(100000 + Math.random() * 900000); // 6-digit code

    const confirmCode = checkCode;
    // generateRandomCode();

    // try {
    //   const transporter = nodemailer.createTransport({
    //     host: "smtp.elasticemail.com",
    //     port: 2525,
    //     auth: {
    //       user: "whiteocjd@gmail.com",
    //       pass: "70028532E494746FB9CD5CDA7519A033E123",
    //     },
    //   });

    //   await transporter.sendMail({
    //     from: "whiteocjd@gmail.com",
    //     to: email,
    //     subject: "Email Confirmation",
    //     html: `Use this verification code: <strong>${confirmCode}</strong>`,
    //   });
    // } catch (error) {
    //   console.error("Email send failed:", error);
    //   throw new Error("Email sending failed");
    // }

    return confirmCode;
  },

  async prepareSignup(userData) {
    const existing = await account.findOne({ where: { email: userData.email } });
    if (existing) throw new Error("Email already exists.");

    const hashedPassword = await bcrypt.hash(userData.password, 10);
 
    // Save plain password for login after signup
    pendingUsers[userData.email] = {
      checkCode,
      userData: {
        ...userData,
        password: hashedPassword
      },
      rawPassword: userData.password
    };

    await this.sendCode(userData.email); 

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
    try {
        const user = await this.checkEmailExisting(email);
        
        if (!user) {
            throw new Error("User not found");
        }

        const isValidPassword = await bcrypt.compare(password, user.password);
        
        if (!isValidPassword) {
            throw new Error("Incorrect password");
        }

        return { user, message: "" };
    } catch (error) {
        throw new Error(error.message || "Login failed");
    }
}
,

  async updatePassword(email, newPassword) {
    const user = await this.checkEmailExisting(email);
    if (!user) throw new Error("User not found");

    user.password = await bcrypt.hash(newPassword, 10);
    await user.save();
    return true;
  },
  async uploadProfilePicture(userId, imageFile) {
    if (!imageFile) {
      throw new Error("No image file uploaded.");
    }

    const validTypes = ['image/jpeg', 'image/png'];
    if (!validTypes.includes(imageFile.mimetype)) {
      throw new Error('Only JPEG and PNG files are allowed.');
    }

    if (imageFile.size > 2 * 1024 * 1024) {
      throw new Error('File size exceeds 2MB.');
    }

    const fileName = `${Date.now()}_${imageFile.name}`;
    const uploadDir = path.join(__dirname, '../public/uploads');

    // Ensure the uploads folder exists
    if (!fs.existsSync(uploadDir)) {
      fs.mkdirSync(uploadDir, { recursive: true });
    }

    const uploadPath = path.join(uploadDir, fileName);
    const dbPath = `/uploads/${fileName}`;

    // Move the file
    await imageFile.mv(uploadPath);

    // Update user record
    const user = await this.findById(userId);
    if (!user) {
      throw new Error("User not found.");
    }

    user.profilePic = dbPath;
    await user.save();

    return dbPath;
  },
  async addLink(userId, linkInfo) {
    try {
    
        const user = await account.findOne({
            where: { accountId: userId },
        });

        if (!user) {
            throw new Error('User not found');
        }

        
        const newLink = await links.create({
            linkUserId: userId, 
            linkName: linkInfo.linkName,
            link: linkInfo.link
        });

        
        return {
            success: true,
            message: 'Link added successfully',
            link: newLink
        };
        
    } catch (error) {
        console.error('Error adding link:', error);
        throw error; 
    }
}

};

module.exports = userService;
