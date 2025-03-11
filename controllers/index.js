const Sequelize = require('sequelize');
const config = require('../config/config.json')[process.env.NODE_ENV || 'development'];
const sequelize = new Sequelize(config.database, config.username, config.password, config);

// تحميل النماذج
const User = require('./models/user')(sequelize, Sequelize.DataTypes);
const Product = require('./models/product')(sequelize, Sequelize.DataTypes);
const ProductColors = require('./models/productColors')(sequelize, Sequelize.DataTypes);
const Photos = require('./models/photos')(sequelize, Sequelize.DataTypes);
const Reservation = require('./models/reservation')(sequelize, Sequelize.DataTypes);

// تجميع النماذج
const models = {
    User,
    Product,
    ProductColors,
    Photos,
    Reservation,
    sequelize,
    Sequelize
};

// استدعاء العلاقات
Object.keys(models).forEach(modelName => {
    if (models[modelName].associate) {
        models[modelName].associate(models);
    }
});

module.exports = models;