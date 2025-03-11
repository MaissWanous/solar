module.exports = (sequelize, DataTypes) => {
    const account = require("./account")(sequelize, DataTypes); 
    const shop = sequelize.define('shop', {
        shopId: {
            type: DataTypes.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        shopKeeperId: {
            type: DataTypes.INTEGER,
            references: {
                model: account, // Reference the imported account model
                key: 'accountId' // Foreign key in the account table
            }
        },
        shopname: {
            type: DataTypes.STRING
        },
        phone: {
            type: DataTypes.INTEGER
        },
     
    });

    return shop;
}