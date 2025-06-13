module.exports = (sequelize, DataTypes) => {
  const battery = sequelize.define("battery", {
    productId: {
      type: DataTypes.INTEGER,
      references: {
        model: 'products',
        key: 'productId'
      }
    },
    batteryType: DataTypes.STRING,
    batterySize: DataTypes.INTEGER
  });

  battery.associate = (models) => {
    battery.belongsTo(models.products, {
      foreignKey: 'productId'
    });
  };

  return battery;
};
