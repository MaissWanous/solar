const { Message, account } = require("../models");
const { Op } = require("sequelize");

const chatService = {
  async getMessagesBetweenUsers(userId, withUserId) {
    return await Message.findAll({
      where: {
        [Op.or]: [
          { senderId: userId, receiverId: withUserId },
          { senderId: withUserId, receiverId: userId }
        ]
      },
      include: [
        {
          model: account,
          as: "sender",
          attributes: ["accountId", "Fname", "profilePic"]
        }
      ],
      order: [["createdAt", "ASC"]]
    });
  },

  async getLastMessages(userId) {
    const lastMessages = await Message.findAll({
      where: {
        [Op.or]: [
          { senderId: userId },
          { receiverId: userId }
        ]
      },
      include: [
        {
          model: account,
          as: "sender",
          attributes: ["accountId", "Fname", "profilePic"]
        }, {
          model: account,
          as: "receiver",
          attributes: ["accountId", "Fname", "profilePic"]
        }
      ],
      order: [["createdAt", "DESC"]]
    });

    // فلترة آخر رسالة لكل محادثة
    const chatMap = new Map();
    for (const msg of lastMessages) {
      const user1 = Math.min(msg.senderId, msg.receiverId);
      const user2 = Math.max(msg.senderId, msg.receiverId);
      const key = `${user1}_${user2}`;
      if (!chatMap.has(key)) {
        chatMap.set(key, msg);
      }
    }

    return Array.from(chatMap.values());
  },

  async saveMessage(senderId, receiverId, content) {
    return await Message.create({
      senderId,
      receiverId,
      content
    });
  }
};

module.exports = chatService;

