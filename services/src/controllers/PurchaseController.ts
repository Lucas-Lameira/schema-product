import { Request, Response } from 'express';
import mysql from 'mysql';

class PurchaseController {
   index(request: Request, response: Response) {

      let connection = mysql.createConnection({
         host: 'localhost',
         user: 'root',
         password: 'password',
         database: 'gerenciamento'
      });

      connection.connect(err => {
         if (err) throw err;
         console.log("Connected");
      });

      let sql = 'CALL purchase_history();';

      connection.query(sql, (error, results) => {
         if (error) {
            throw error;
         }
         else {
            return response.json(results[0]);
         }
      });

      connection.end(err => {
         if (err)
            throw err;
         else
            console.log('connection is closed');
      })
   }
}

export default PurchaseController;