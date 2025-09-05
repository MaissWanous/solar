module.exports = (sequelize, DataTypes) => {
  const account = sequelize.define('account', {
    accountId: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true
    },
    Fname: DataTypes.STRING,
    Lname: DataTypes.STRING,
    email: DataTypes.STRING,
    phone: DataTypes.INTEGER,
    password: DataTypes.STRING,
    country: DataTypes.STRING,
    type: DataTypes.STRING,
    profilePic: {
      type: DataTypes.STRING,
      allowNull: true
    }
  });

  // تعريف العلاقات هنا لكن بدون استدعاء Message مباشرة
  account.associate = (models) => {
    account.hasMany(models.Message, {
      as: "sentMessages",
      foreignKey: "senderId"
    });

    account.hasMany(models.Message, {
      as: "receivedMessages",
      foreignKey: "receiverId"
    });
  };

  return account;
};
