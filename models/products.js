module.exports = (sequelize, DataTypes) => {
  const products = sequelize.define('products', {
    productId: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true
    },
    shopId: DataTypes.INTEGER,
    picture:DataTypes.STRING,
    name: DataTypes.STRING,
    price: DataTypes.INTEGER,
    description:DataTypes.STRING,
    category: DataTypes.STRING
  });

  // Associations (define inside an `associate` method if you're using index.js structure)
  products.associate = (models) => {
    products.belongsTo(models.shop, {
      foreignKey: 'shopId'
    });

    products.hasOne(models.battery, {
      foreignKey: 'productId'
    });

    products.hasOne(models.inverter, {
      foreignKey: 'productId'
    });

    products.hasOne(models.solar_panel, {
      foreignKey: 'productId'
    });
  
  products.hasMany(models.rating, {
    foreignKey: 'productId'
  });
};
  return products;
};
