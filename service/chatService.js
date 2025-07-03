const { Message } = require("../models");
const { Op, Sequelize } = require("sequelize");

const chatService = {
  async getMessagesBetweenUsers(userId, withUserId) {
    return await Message.findAll({
      where: {
        [Op.or]: [
          { senderId: userId, receiverId: withUserId },
          { senderId: withUserId, receiverId: userId }
        ]
      },
      order: [['createdAt', 'ASC']]
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
      order: [['createdAt', 'DESC']],
      raw: true
    });

    // Filter to get the last message per chat 
    const chatMap = new Map();

    for (const msg of lastMessages) {
      const user1 = Math.min(msg.senderId, msg.receiverId);
      const user2 = Math.max(msg.senderId, msg.receiverId);
      const key = `${user1}_${user2}`;
      if (!chatMap.has(key)) {
        chatMap.set(key, msg); // خزن أول رسالة تمر (لأنها الأحدث)
      }
    }

    return Array.from(chatMap.values());
  }
  ,
  async saveMessage(senderId, receiverId, content) {
    return await Message.create({
      senderId,
      receiverId,
      content
    });
  }
};

module.exports = chatService;
