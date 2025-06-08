module.exports=(sequelize, DataTypes)=>{
    const  products= require("./products")(sequelize, DataTypes); 
    const inverter =sequelize.define("inverter",{
        productId: {
            type: DataTypes.INTEGER,
            references: {
                model: products, 
                key: 'productId' 
            }
        },
        inverterRatingP: {
            type: DataTypes.INTEGER
        },
        maxAc: {
            type: DataTypes.INTEGER
        },
        defaultAc: {
            type: DataTypes.INTEGER
        },
        solarRatingP: {
            type: DataTypes.INTEGER
        },
        maxSolarVolt: {
            type: DataTypes.INTEGER
        },
        Mppt: {
            type: DataTypes.INTEGER
        },

    })
    return inverter;
}