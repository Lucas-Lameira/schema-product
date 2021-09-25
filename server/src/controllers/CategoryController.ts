import { Request, Response } from 'express';
import { openConnection, closeConnection } from '../connection';

export class CategoryController {
   index(request: Request, response: Response) {
      const connection = openConnection();

      connection.query("CALL get_categories()", (error, results) => {
         if (error)
            throw error;
         else
            return response.json(results[0]); // [{},{},{}]
      })

      closeConnection(connection);
   }
}