module.exports=(sequelize, DataTypes)=>{
    const  products= require("./products")(sequelize, DataTypes); 
    const solar_panel =sequelize.define("solar_panel",{
        productId: {
            type: DataTypes.INTEGER,
            references: {
                model: products, 
                key: 'produtId' 
            }
        },
        maximumPower: {
            type: DataTypes.INTEGER
        },
        shortCurrent: {
            type: DataTypes.INTEGER
        },
        openVoltage: {
            type: DataTypes.INTEGER
        },

    })
    return solar_panel;
}