const { Message } = require("../models");
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
      order: [['createdAt', 'ASC']]
    });
  },
  async getMessages(userId) {
    return await Message.findAll({
      where: {
        [Op.or]: [
          { senderId: userId },
          { receiverId: userId }
        ]
      },
      order: [['createdAt', 'ASC']]
    });
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
