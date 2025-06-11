module.exports = (sequelize, DataTypes) => {
    const products = require("./products")(sequelize, DataTypes);
    
    const battery = sequelize.define("battery", {
        productId: {
            type: DataTypes.INTEGER,
            references: {
                model: products,
                key: 'productId'
            }
        },
        batteryType: { type: DataTypes.STRING },
        batterySize: { type: DataTypes.INTEGER }
    });

    // تعريف العلاقة بين البطارية والمنتج
    battery.belongsTo(products, { foreignKey: 'productId' });

    return battery;
};