module.exports = (sequelize, DataTypes) => {
    const  shop= require("./shop")(sequelize, DataTypes); 
    const products = sequelize.define('products', {
        productId: {
            type: DataTypes.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        shopId: {
            type: DataTypes.INTEGER,
            references: {
                model: shop, 
                key: 'shopId' 
            }
        },
        picture: {
            type: DataTypes.STRING
        },
        category: {
            type: DataTypes.STRING
        },
        description: {
            type: DataTypes.STRING
        },
     
    });

    return products;
}