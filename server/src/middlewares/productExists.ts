import { openConnection, closeConnection } from '../connection';

export function productAlreadyExists() {
   const connection = openConnection()

   connection.query("CALL productAlreadyExists(?);", (error, results) => {
      if (error) {
         return error
      }
   })

   closeConnection(connection);
}