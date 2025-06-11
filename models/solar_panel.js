module.exports = (sequelize, DataTypes) => {
    const products = require("./products")(sequelize, DataTypes);
    
    const solar_panel = sequelize.define("solar_panel", {
        productId: {
            type: DataTypes.INTEGER,
            references: {
                model: products,
                key: 'productId'
            }
        },
        maximumPower: { type: DataTypes.INTEGER },
        shortCurrent: { type: DataTypes.INTEGER },
        openVoltage: { type: DataTypes.INTEGER }
    });

    // تعريف العلاقة بين اللوح الشمسي والمنتج
    solar_panel.belongsTo(products, { foreignKey: 'productId' });

    return solar_panel;
};