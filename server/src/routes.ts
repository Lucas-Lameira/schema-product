import { Router } from 'express';
import { CategoryController } from './controllers/CategoryController';
import { ProductController } from './controllers/ProductController';
import PurchaseController from './controllers/PurchaseController';

const router = Router();

const productController = new ProductController();
const purchaseController = new PurchaseController();
const categoryController = new CategoryController();

router.get('/products', productController.index);
router.post('/products', productController.create);
router.delete('/products/:id', productController.delete);
/* router.put('/products/:id');
router.patch('/products/:id');
 */

router.get('/categories', categoryController.index);

router.get('/purchase', purchaseController.index);

export { router };