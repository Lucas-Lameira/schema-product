import { openConnection, closeConnection } from '../connection';

interface ICreateProduct {
   name: string;
   quantity: number;
   price: number;
   min_qty: number;
   id_category: number;
}

export class CreateProductService {
   execute({ name, quantity, price, min_qty, id_category }: ICreateProduct) {

      const sql = 'CALL add_new_product(?, ?, ?, ?, ?)';

      const connection = openConnection();

      connection.query(sql, [name, quantity, price, min_qty, id_category], (error, results) => {
         if (error)
            throw error;

         return results[0]; // [{x: y}]
      });

      closeConnection(connection);
   }
}