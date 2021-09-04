import express from 'express';
const app = express();
const port = process.env.PORT || 3000;

import ProductsController from './controllers/ProductsController';
import PurchaseController from './controllers/PurchaseController';

const productsController = new ProductsController();
const purchaseController = new PurchaseController();

/* routes */
app.get('/products', productsController.index);
app.post('/products', productsController.create);



app.get('/purchase', purchaseController.index);

app.listen(port, () => {
  console.log(`Example app listening at http://localhost:${port}`)
})
