var createError = require('http-errors');
var express = require('express');
const bodyParser = require('body-parser');
const mysql = require('mysql2');
// var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');

var indexRouter = require('./routes/index');
var usersRouter = require('./routes/users');


// var app = express();
const app = express()
const port = 4000

// view engine setup
// app.set('views', path.join(__dirname, 'views'));
// app.set('view engine', 'pug');

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());
// app.use(express.static(path.join(__dirname, 'public')));

app.use('/user_table',require('./API_Gateways/Usertable_Gateway'));

app.use('/api/user_table',usersRouter)

// app.use('/', indexRouter);
// app.use('/users', usersRouter);

const pool = mysql.createPool({
  connectionLimit : 10,
  host : 'localhost',
  user : 'root',
  password : '12345678',
  database : 'wasail',
})

// app.get('/user_table',(req,res) => {
//   pool.getConnection((err,connection) => {
//     if (err) throw err
//     connection.query("Select * from user_table",(err,rows) => {
//       connection.release();
//       if(!err){
//         res.send(rows)
//       }
//       else{
//         console.log(err)
//       }
//     })
//   })
// })

// app.get('/:user_id',(req,res) => {
//   pool.getConnection ((err,connection) => {
//     if (err) throw err
//     connection.query("Select * from user_table WHERE user_id = ?",[req.params.user_id],(err,rows) => {
//       connection.release();
//       if(!err){
//         res.send(rows)
//       }
//       else{
//         console.log(err)
//       }
//     })
//   })
// })
//
// app.delete('/:user_id',(req,res) => {
//   pool.getConnection((err,connection) => {
//     if (err) throw err
//     console.log(`connected as id ${connection.threadId}`)
//     connection.query("DELETE from user_table WHERE user_id = ?",[req.params.user_id],(err,rows) => {
//       connection.release();
//       if(!err){
//         res.send(`User with the Record ID: ${[req.params.user_id]} has been removed.`)
//       }
//       else{
//         console.log(err)
//       }
//     })
//   })
// })

// app.post('',(req,res) => {
//   pool.getConnection((err,connection) => {
//     if (err) throw err
//     console.log(`connected as id ${connection.threadId}`)
//
//     const params = req.body
//
//     connection.query("INSERT INTO user_table SET ?",params,(err,rows) => {
//       connection.release();
//       if(!err){
//         res.send(`User with the Record ID: ${params.user_id} has been added.`)
//       }
//       else{
//         console.log(err)
//       }
//     })
//     console.log(req.body)
//   })
// })

// app.put('',(req,res) => {
//   pool.getConnection((err,connection) => {
//     if (err) throw err
//     console.log(`connected as id ${connection.threadId}`)
//
//     const {user_id, phone_number, name, password,username,language,user_type} = req.body
//
//     connection.query("UPDATE user_table SET name =  ? WHERE user_id = ?",[name,user_id],(err,rows) => {
//       connection.release();
//       if(!err){
//
//         res.send(`Grocery Store has been updated.`)
//
//         res.send(`User with the Record ID: has been added.`)
//
//       }
//       else{
//         console.log(err)
//       }
//     })
//     console.log(req.body)
//   })
// })

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
