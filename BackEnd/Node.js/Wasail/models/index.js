'use strict';

const fs = require('fs');
const path = require('path');
const Sequelize = require('sequelize');
const process = require('process');
const basename = path.basename(__filename);
const config = require('../config/config');
const db = {};
db.user_table = require('./usertable');
db.vendor = require('./vendor');
db.grocery_store = require('./grocerystore');
db.order = require('./order');
db.order_detail = require('./orderdetail');
console.log(config);


const sequelize = new Sequelize(config.db.database, config.db.username, config.db.password,{
  dialect : 'mysql',
  host : config.db.host
});

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
    const model = require(path.join(__dirname, file))(sequelize, Sequelize.DataTypes);
    db[model.name] = model;
  });

Object.keys(db).forEach(modelName => {
  if (db[modelName].associate) {
    db[modelName].associate(db);
  }
});

db.sequelize = sequelize;
db.Sequelize = Sequelize;

db.user_table.hasOne(db.vendor);
db.vendor.belongsTo(db.user_table);

db.user_table.hasOne(db.grocery_store);
db.grocery_store.belongsTo(db.user_table);

db.grocery_store.hasMany(db.order);
db.order.belongsTo(db.grocery_store);

db.vendor.hasMany(db.order);
db.order.belongsTo(db.vendor);

db.order.hasMany(db.order_detail);
db.order_detail.belongsTo(db.order);

sequelize
    .authenticate()
    .then(() => {
      console.log('Connection has been established successfully.');
    })
    .catch(err => {
      console.error('Unable to connect to the database',err);
    });

module.exports = db;
