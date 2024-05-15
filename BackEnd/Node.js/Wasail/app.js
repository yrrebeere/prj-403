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

// app.use((req, res, next) => {
//   res.setHeader('Access-Control-Allow-Origin', '*');
//   res.setHeader('Access-Control-Allow-Methods', 'POST, PUT, GET, OPTIONS');
//   res.setHeader('Access-Control-Allow-Headers', 'Content-Type, Authorization');
//   if (req.method === 'OPTIONS') {
//     res.sendStatus(200);
//   } else {
//     next();
//   }
// });

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
  password : 'AVNS_IjfxfxsgiZ5GzaEZ3A_',
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
