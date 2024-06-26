var createError = require('http-errors');
var express = require('express');
const bodyParser = require('body-parser');
const mysql = require('mysql2');
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
var imagesRouter = require('./routes/images');
var predictionsRouter = require('./routes/predictions');

const app = express();
app.use(cors())
const port = 4000

app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());

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
app.use('/api/image',imagesRouter)
app.use('/api/prediction',predictionsRouter)

const pool = mysql.createPool({
  connectionLimit : 10,
  host : 'localhost',
  user : 'root',
  password : '12345678',
  database : 'wasail',
})

app.listen(port,() => console.log(`listen on port ${port}`))

app.use(function(req, res, next) {
  next(createError(404));
});

app.use(function(err, req, res, next) {
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  res.status(err.status || 500);

});

module.exports = app;
