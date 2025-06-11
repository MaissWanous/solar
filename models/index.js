'use strict';

const fs = require('fs');
const path = require('path');
const Sequelize = require('sequelize');
const process = require('process');
const basename = path.basename(__filename);
const env = process.env.NODE_ENV || 'development';
const config = require(__dirname + '/../config/config.json')[env];
///////////////////////////////

// const Sequelize = require("sequelize");
let sequelize = new Sequelize("solar", "root", "1234", {
    host: "localhost",
    dialect: "mysql", // أو أي قاعدة بيانات تستخدمها
    port: 3306
});

const products = require("./products")(sequelize, Sequelize.DataTypes);
const inverter = require("./inverter")(sequelize, Sequelize.DataTypes);
const solar_panel = require("./solar_panel")(sequelize, Sequelize.DataTypes);
const battery = require("./battery")(sequelize, Sequelize.DataTypes);

// تعريف العلاقات بين المنتجات والمكونات الأخرى
products.hasOne(inverter, { foreignKey: 'productId' });
inverter.belongsTo(products, { foreignKey: 'productId' });

products.hasOne(solar_panel, { foreignKey: 'productId' });
solar_panel.belongsTo(products, { foreignKey: 'productId' });

products.hasOne(battery, { foreignKey: 'productId' });
battery.belongsTo(products, { foreignKey: 'productId' });

const db = {
    sequelize,
    Sequelize,
    products,
    inverter,
    solar_panel,
    battery
};

module.exports = db;

if (config.use_env_variable) {
  sequelize = new Sequelize(process.env[config.use_env_variable], config);
} else {
  sequelize = new Sequelize(config.database, config.username, config.password, config);
}

fs
  .readdirSync(__dirname)
  .filter(file => {
    return (
      file.indexOf('.') !== 0 &&
      file !== basename &&
      file.slice(-3) === '.js' &&
      file.indexOf('.test.js') === -1
    );
  })
  .forEach(file => {
    const modelPath = path.join(__dirname, file);
    const modelFactory = require(modelPath);
    if (typeof modelFactory === 'function') {
      const model = modelFactory(sequelize, Sequelize.DataTypes);
      if (model && model.name) {
        db[model.name] = model;
      } else {
        console.warn(`Warning: Model from file "${file}" is missing a name.`);
      }
    } else {
      console.warn(`Warning: File "${file}" does not export a model factory function.`);
    }
  });

Object.keys(db).forEach(modelName => {
  if (db[modelName].associate) {
    db[modelName].associate(db);
  }
});

db.sequelize = sequelize;
db.Sequelize = Sequelize;

module.exports = db;
