module.exports = (sequelize, DataTypes) => {
    const account = require("./account")(sequelize, DataTypes); 
    const rating = sequelize.define('rating', {
       
        factorId: {
            type: DataTypes.INTEGER,
            references: {
                model: account, // Reference the imported account model
                key: 'accountId' // Foreign key in the account table
            }
        },
        customerId: {
            type: DataTypes.INTEGER,
            references: {
                model: account, // Reference the imported account model
                key: 'accountId' // Foreign key in the account table
            }
        },
        rating: {
            type: DataTypes.STRING
        },
        stars: {
            type: DataTypes.FLOAT
        },
     
    });

    return rating;
}