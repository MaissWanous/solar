module.exports = (sequelize, DataTypes) => {
  const Message = sequelize.define("Message", {
    senderId: {
      type: DataTypes.INTEGER,
      allowNull: false
    },
    receiverId: {
      type: DataTypes.INTEGER,
      allowNull: false
    },
    content: {
      type: DataTypes.TEXT,
      allowNull: false
    }
  });

  Message.associate = (models) => {
    Message.belongsTo(models.account, {
      as: "sender",
      foreignKey: "senderId"
    });

    Message.belongsTo(models.account, {
      as: "receiver",
      foreignKey: "receiverId"
    });
  };

  return Message;
};
