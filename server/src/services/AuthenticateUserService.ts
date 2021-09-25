import { FindUserService } from "./findUserService"

interface IAuthRequest {
   email: string;
   password: string;
}

export class AuthenticateUserService {
   async execute({ email, password }: IAuthRequest) {
      const findUserService = new FindUserService();

      const user = findUserService.execute(email);

      return user;
   }
}