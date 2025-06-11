module.exports = (sequelize, DataTypes) => {
    const products = require("./products")(sequelize, DataTypes);
    
    const inverter = sequelize.define("inverter", {
        productId: {
            type: DataTypes.INTEGER,
            references: {
                model: products,
                key: 'productId'
            }
        },
        inverterRatingP: { type: DataTypes.INTEGER },
        maxAc: { type: DataTypes.INTEGER },
        defaultAc: { type: DataTypes.INTEGER },
        solarRatingP: { type: DataTypes.INTEGER },
        maxSolarVolt: { type: DataTypes.INTEGER },
        Mppt: { type: DataTypes.INTEGER }
    });

    // تعريف العلاقة بين العاكس والمنتج
    inverter.belongsTo(products, { foreignKey: 'productId' });
    products.hasOne(inverter, { foreignKey: 'productId' }); // تأكد من إضافة هذا السطر

    return inverter;
};