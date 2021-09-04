import { Request, Response } from 'express';
import mysql from 'mysql';

class ProductsController {
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

      let sql = 'CALL search_all_products();';

      connection.query(sql, (error, results) => {
         if (error) {
            throw error;
         }
         else {
            //console.log(results); // [{},{},{}]
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

   create(request: Request, response: Response) {
      response.send("created")
   }
}

export default ProductsController;