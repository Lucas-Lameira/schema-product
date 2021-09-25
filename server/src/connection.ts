import mysql, { Connection } from 'mysql';

export function openConnection(): Connection {
   const connection = mysql.createConnection({
      host: 'localhost',
      user: 'root',
      password: 'password',
      database: 'gerenciamento'
   });

   connection.connect(err => {
      if (err) {
         console.error('error connecting: ' + err.stack);
         throw err;
      }

      console.log("Connected");
   });

   return connection;
}

export function closeConnection(connection: Connection) {
   connection.end(err => {
      if (err)
         throw err;
      else
         console.log('connection is closed');
   })
}