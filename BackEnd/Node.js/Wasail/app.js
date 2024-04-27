var createError = require('http-errors');
var express = require('express');
const bodyParser = require('body-parser');
const mysql = require('mysql2');
// var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');
var cors = require('cors')

var indexRouter = require('./routes/index');
var usersRouter = require('./routes/users');
var vendorsRouter = require('./routes/vendors');
var storesRouter = require('./routes/stores');
var ordersRouter = require('./routes/orders');
var detailsRouter = require('./routes/details');
var categoriesRouter = require('./routes/categories');
var productsRouter = require('./routes/products');
var inventoriesRouter = require('./routes/inventories');
var registrationsRouter = require('./routes/registrations');
var listsRouter = require('./routes/lists');
var adminsRouter = require('./routes/admins');

// var app = express();
const app = express()
app.use(cors())

const port = 4000
// const port = 25060

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());

// app.use(express.static(path.join(__dirname, 'public')));
// app.use('/user_table',require('./API_Gateways/Usertable_Gateway'));

app.use('/api/user_table',usersRouter)
app.use('/api/vendor',vendorsRouter)
app.use('/api/grocery_store',storesRouter)
app.use('/api/order',ordersRouter)
app.use('/api/order_detail',detailsRouter)
app.use('/api/product_category',categoriesRouter)
app.use('/api/product',productsRouter)
app.use('/api/product_inventory',inventoriesRouter)
app.use('/api/registration',registrationsRouter)
app.use('/api/list',listsRouter)
app.use('/api/admin',adminsRouter)

// const pool = mysql.createPool({
//   connectionLimit : 10,
//   host : 'localhost',
//   user : 'root',
//   password : '12345678',
//   database : 'wasail',
// })

const pool = mysql.createPool({
  connectionLimit : 10,
  host : 'db-mysql-nyc3-39234-do-user-15490202-0.c.db.ondigitalocean.com',
  user : 'admin',
  password : 'AVNS_mxM7im2Y4B6CZozyRK4',
  database : 'wasail',
})

app.listen(port,() => console.log(`listen on port ${port}`))

// catch 404 and forward to error handler
app.use(function(req, res, next) {
  next(createError(404));
});

// error handler
app.use(function(err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // render the error page
  res.status(err.status || 500);

});

module.exports = app;
