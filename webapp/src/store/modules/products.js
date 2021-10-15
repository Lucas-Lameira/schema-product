import api from '../../services/api';

const state = {
   //product state
   products: [],
   categories: [],
   isFiltering: false,
};


// make a req, get a res, call mutation
const actions = {

   async fetchProducts(context) {
      try {
         const result = await api.get("/products");
         console.log(result.data)
         context.commit('setProducts', result.data);
         context.commit('setIsFiltering', false);
      } catch (error) {
         console.log(error);
         /* this.errored = true; */
      } finally {
         /* this.loading = false; */
      }
   },

   async addNewProduct(context, newProduct) {
      try {
         const result = await api.post("/products", newProduct);
         console.log(result.data[0]);
         context.commit('setNewProduct', result.data[0])
      } catch (error) {
         console.log(error);
      }
   },

   async updateProduct(context, product) {
      try {

         //id, nome, quantidade, preco, quantidademinima, islowStock, idcategoria, categoria
         const values = product.filter((item, index) => { return index != 5 && index != 7 && item })

         const result = await api.put('/products', values, {
            params: { id: product[0] }
         });

         context.commit('setUpdatedProduct', result.data[0])
      } catch (error) {

      }
   },

   async deleteProduct(context, productId) {
      try {
         const result = await api.delete("/products", { params: { id: productId } })
         console.log(result)
         context.commit('removeProduct', productId)
      } catch (error) {
         console.log(error)
      }
   },

   async fetchCategories(context) {
      try {
         const result = await api.get('/categories')
         context.commit('setCategories', result.data)
      } catch (error) {
         console.log(error)
      }
   },

   async filteredProducts(context, category) {
      try {
         const categoryId = category[0];

         const result = await api.get(`/products/categories?id=${categoryId}`);

         context.commit('setProducts', result.data)
         context.commit('setIsFiltering', true)
      } catch (error) {
         console.log(error)
      }
   },

};


const mutations = {
   //product mutations
   setProducts: (state, products) => { state.products = products },
   setNewProduct: (state, product) => { state.products.unshift(product) },
   setCategories: (state, categories) => { state.categories = categories },
   removeProduct: (state, id) => { state.products = state.products.filter(product => product[0] !== id) },
   setUpdatedProduct: (state, product) => { console.log("produto atualizado", product) },
   setIsFiltering: (state, isFiltering) => { state.isFiltering = isFiltering }
};


const getters = {
   // product getters
   allProducts: (state) => state.products,
   allCategories: (state) => state.categories,
   isFiltering: (state) => state.isFiltering,
};


export default {
   state,
   actions,
   mutations,
   getters
}