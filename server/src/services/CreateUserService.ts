interface IUser {
   name: string;
   email: string;
   password: string;
}

export class CreateUserService {
   execute({ name, email, password }: IUser) {

      // validar o email
      // throw new Error("msg") // erro lançado pra quem fez a requisição

      //hash na senha


   }
}