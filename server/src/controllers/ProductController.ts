import { Request, Response } from 'express';
import { openConnection, closeConnection } from '../connection';
//import { CreateProductService } from '../services/CreateProductService';

export class ProductController {
   index(request: Request, response: Response) {
      const connection = openConnection();
      const sql = 'CALL get_products()';

      connection.query(sql, (error, results) => {
         if (error)
            throw error;
         else
            return response.json(results); // [{},{},{}]
      });

      closeConnection(connection);
   }

   create(request: Request, response: Response) {
      const { name, quantity, price, min_qty, id_category } = request.body;

      const connection = openConnection();
      const sql = 'CALL add_new_product(?, ?, ?, ?, ?)';

      connection.query(sql, [name, quantity, price, min_qty, id_category], (error, results) => {
         if (error) {
            return response.status(400).json(error.message);
         }

         return response.status(201).json(results[0][0]); //{cod_produto: x}
      });

      closeConnection(connection);
   }



   delete(request: Request, response: Response) {
      const { product_id, email, password } = request.params; // hellooo

      const connection = openConnection();
      const sql = 'CALL delete_product(?, ?, ?)';

      connection.query(sql, [product_id, email, password], (error, results) => {
         if (error) {
            return response.status(400).json(error.message);
         }

         return response.status(201).json(results[0][0]); //{cod_produto: x}
      });

      closeConnection(connection);
   }
}