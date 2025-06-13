module.exports = (sequelize, DataTypes) => {
  const solar_panel = sequelize.define(
    "solar_panel",
    {
      productId: {
        type: DataTypes.INTEGER,
        references: {
          model: 'products',
          key: 'productId'
        }
      },
      maximumPower: DataTypes.INTEGER,
      shortCurrent: DataTypes.INTEGER,
      openVoltage: DataTypes.INTEGER
    }
  );

  solar_panel.associate = (models) => {
    solar_panel.belongsTo(models.products, {
      foreignKey: 'productId'
    });
  };

  return solar_panel;
};
