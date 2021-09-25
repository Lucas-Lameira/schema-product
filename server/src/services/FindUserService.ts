import { closeConnection, openConnection } from "../connection";

export class FindUserService {
   execute(email: string) {
      const connection = openConnection();

      const user = connection.query("CALL get_user(?)", email, (error, results) => {
         if (error) {
            throw new Error("error in DB query");
         }

         return results;
      })

      closeConnection(connection);

      return user.values
   }
}