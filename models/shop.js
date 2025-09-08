module.exports = (sequelize, DataTypes) => {
  const shop = sequelize.define('shop', {
    shopId: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true
    },
    shopKeeperId: {
      type: DataTypes.INTEGER,
      allowNull: false
    },
    shopname: DataTypes.STRING,
    phone: DataTypes.INTEGER
  });

  shop.associate = (models) => {
    shop.belongsTo(models.account, {
      foreignKey: 'shopKeeperId'
    });
  };

  return shop;
};
