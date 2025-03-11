module.exports=(sequelize, DataTypes)=>{
    const  products= require("./products")(sequelize, DataTypes); 
    const battery =sequelize.define("battery",{
        productId: {
            type: DataTypes.INTEGER,
            references: {
                model: products, 
                key: 'produtId' 
            }
        },
        batteryType: {
            type: DataTypes.STRING
        },
        batterySize: {
            type: DataTypes.INTEGER
        },

    })
    return battery;
}