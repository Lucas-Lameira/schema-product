import mysql from 'mysql';
const { db_host, db_user, db_password } = require('../config')

let connection = mysql.createConnection({
   host: db_host,
   user: db_user,
   password: db_password,
   database: 'gerenciamento'
})

connection.connect(err => {
   if (err) throw err;
   console.log("Connected");
})

connection.end(err => {
   if (err) {
      return console.log(`deu erro: ${err}`)
   }

   console.log('connection is closed')
})