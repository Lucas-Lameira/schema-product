import { Request, Response, Router } from 'express';
import { openConnection, closeConnection } from '../connection'
import { AuthenticateUserController } from '../controllers/AuthenticateUserController';

const userRouter = Router();

const authenticateUserController = new AuthenticateUserController();


userRouter.get('/user', (request: Request, response: Response) => {
   const email = 'lucaslameira@gmail.com';

   const connection = openConnection();

   const sql = "CALL get_user(?)"

   connection.query(sql, email, (error, results) => {
      if (error) {
         throw error;
      }

      const user = results[0][0];

      if (!user) {
         throw error;
      }

      return response.status(200).json(user);
   })

   closeConnection(connection);
})


userRouter.post('/user', (request: Request, response: Response) => {
   const { name, email, password } = request.body;

   const connection = openConnection();

   const sql = "CALL create_user(?, ?, ?)";

   connection.query(sql, [name, email, password], (error, results) => {
      /* 
      if (error) {
         throw error;
      } */

      if (error) {
         return response.status(400).json(error);
      }

      const user = results[0][0];

      return response.status(201).json(user);
   })

   closeConnection(connection);
})

userRouter.post('/login', authenticateUserController.handle)

export default userRouter;