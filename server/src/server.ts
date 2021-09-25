import dotenv from 'dotenv';
import express, { NextFunction, Request, response, Response } from 'express';
import cors from 'cors';
import { router } from './routes';
import userRouter from './routes/user.routes';
import 'express-async-errors'
dotenv.config();

const PORT = process.env.PORT || 3000;
const app = express();

// give access to other apps 
app.use(cors());

// middleware to parse json
app.use(express.json());

app.use(router);
app.use(userRouter);

app.get('/', (req, res) => {
  res.send("ok")
})

// middleware to catch errors
app.use((error: Error, request: Request, response: Response, next: NextFunction) => {
  if (error instanceof Error) {
    return response.status(400).json({
      error: error.message,
      teste: "teste"
    })
  }

  return response.status(500).json({
    status: "error",
    message: "server error"
  })
})


app.listen(PORT, () => {
  console.log(`Example app listening at http://localhost:${PORT}`)
})
