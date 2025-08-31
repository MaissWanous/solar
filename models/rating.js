module.exports = (sequelize, DataTypes) => {
    const account = require("./account")(sequelize, DataTypes);
    const products = require("./products")(sequelize, DataTypes);
    const rating = sequelize.define('rating', {

        productId: {
            type: DataTypes.INTEGER,
            references: {
                model: products, // Reference the imported products model
                key: 'productId' // Foreign key in the products table
            }
        },
        customerId: {
            type: DataTypes.INTEGER,
            references: {
                model: account, // Reference the imported account model
                key: 'accountId' // Foreign key in the account table
            }
        },
        review: {
            type: DataTypes.STRING
        },
        stars: {
            type: DataTypes.FLOAT
        },

    });
    rating.associate = (models) => {
        rating.belongsTo(models.products, {
            foreignKey: 'productId'
        });

        rating.belongsTo(models.account, {
            foreignKey: 'customerId'
        });
    };

    return rating;
}