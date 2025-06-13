module.exports = (sequelize, DataTypes) => {
  const inverter = sequelize.define(
    "inverter",
    {
      productId: {
        type: DataTypes.INTEGER,
        references: {
          model: 'products',
          key: 'productId'
        }
      },
      inverterRatingP: DataTypes.INTEGER,
      maxAc: DataTypes.INTEGER,
      defaultAc: DataTypes.INTEGER,
      solarRatingP: DataTypes.INTEGER,
      maxSolarVolt: DataTypes.INTEGER,
      Mppt: DataTypes.INTEGER
    }
  );

  inverter.associate = (models) => {
    inverter.belongsTo(models.products, {
      foreignKey: 'productId'
    });
  };

  return inverter;
};
