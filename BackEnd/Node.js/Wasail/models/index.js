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
db.product_category = require('./productcategory');
db.product = require('./product');
db.product_inventory = require('./productinventory');
db.list = require('./list');
db.admin = require('./admin');
db.image = require('./image');

console.log(config);

const sequelize = new Sequelize(config.db.database, config.db.username, config.db.password,{
  dialect : 'mysql',
  host : config.db.host,
  port : 25060,
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

//user_table-vendor
db.user_table.hasOne(db.vendor);
db.vendor.belongsTo(db.user_table);

//user_table-grocery_store
db.user_table.hasOne(db.grocery_store);
db.grocery_store.belongsTo(db.user_table);

//user_table-admin
db.user_table.hasOne(db.admin);
db.admin.belongsTo(db.user_table);

//grocery_store/vendor-order
db.grocery_store.hasMany(db.order);
db.order.belongsTo(db.grocery_store);
db.vendor.hasMany(db.order);
db.order.belongsTo(db.vendor);

//order-order_details
db.order.hasMany(db.order_detail);
db.order_detail.belongsTo(db.order);

//product_inventory-order_details
db.product_inventory.hasMany(db.order_detail);
db.order_detail.belongsTo(db.product_inventory);

//grocery_store-vendor
db.grocery_store.belongsToMany(db.vendor, {through: 'lists'})
db.vendor.belongsToMany(db.grocery_store, {through: 'lists'})

//productcategory-product
db.product_category.belongsToMany(db.product, {through: 'product_category_links'})
db.product.belongsToMany(db.product_category, {through: 'product_category_links'})

//product-productinventory || productinventory-vendor
db.product.hasMany(db.product_inventory);
db.product_inventory.belongsTo(db.product);
db.vendor.hasMany(db.product_inventory);
db.product_inventory.belongsTo(db.vendor);

sequelize
    .authenticate()
    .then(() => {
      console.log('Connection has been established successfully.');
    })
    .catch(err => {
      console.error('Unable to connect to the database',err);
    });

module.exports = db;
