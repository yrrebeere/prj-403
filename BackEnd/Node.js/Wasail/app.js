var createError = require('http-errors');
var express = require('express');
const bodyParser = require('body-parser');
const mysql = require('mysql');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');

var indexRouter = require('./routes/index');
var usersRouter = require('./routes/users');

// var app = express();
const app = express()
const port = 5000
// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'pug');


app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

app.use('/', indexRouter);
app.use('/users', usersRouter);

const pool = mysql.createPool({
  connectionLimit : 10,
  host : 'localhost',
  user : 'root',
  password : '',
  database : 'wasail',
})

app.get('/grocery_store',(req,res) => {
  pool.getConnection((err,connection) => {
    if (err) throw err
    connection.query("Select * from grocery_store",(err,rows) => {
      connection.release();
      if(!err){
        res.send(rows)
      }
      else{
        console.log(err)
      }
    })

  })
})

app.get('/:store_id',(req,res) => {
  pool.getConnection((err,connection) => {
    if (err) throw err
    connection.query("Select * from grocery_store WHERE store_id = ?",[req.params.store_id],(err,rows) => {
      connection.release();
      if(!err){
        res.send(rows)
      }
      else{
        console.log(err)
      }
    })

  })
})

app.delete('/:store_id',(req,res) => {
  pool.getConnection((err,connection) => {
    if (err) throw err
    console.log(`connected as id ${connection.threadId}`)
    connection.query("DELETE from grocery_store WHERE store_id = ?",[req.params.store_id],(err,rows) => {
      connection.release();
      if(!err){
        res.send(`Grocery Store with the Record ID: ${[req.params.store_id]} has been removed.`)
      }
      else{
        console.log(err)
      }
    })

  })
})

app.post('',(req,res) => {
  pool.getConnection((err,connection) => {
    if (err) throw err
    console.log(`connected as id ${connection.threadId}`)

    const params = req.body

    connection.query("INSERT INTO grocery_store SET ?",params,(err,rows) => {
      connection.release();
      if(!err){
        res.send(`Grocery Store with the Record ID: ${params.store_id} has been added.`)
      }
      else{
        console.log(err)
      }
    })

    console.log(req.body)
  })
})

app.put('',(req,res) => {
  pool.getConnection((err,connection) => {
    if (err) throw err
    console.log(`connected as id ${connection.threadId}`)

    const {store_id, name, store_name,store_address,mobile_number} = req.body

    connection.query("UPDATE grocery_store SET name =  ? WHERE store_id = ?",[name,store_id],(err,rows) => {
      connection.release();
      if(!err){
        res.send(`Grocery Store with the Record ID: has been added.`)
      }
      else{
        console.log(err)
      }
    })

    console.log(req.body)
  })
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
  res.render('error');
});

module.exports = app;
