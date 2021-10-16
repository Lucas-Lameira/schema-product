import api from '../../services/api';


const state = {
   productsForSale: [],
   cart: [],
   isLoading: true,
   isErrored: false
}


const actions = {
   async fetchProductsForSale(context) {
      try {
         const result = await api.get('/sales');
         context.commit('SET_PRODUCTS_FOR_SALE', result.data)
      } catch (error) {
         console.log(error)
         context.commit('SET_IS_LOADING', true)
      } finally {
         context.commit('SET_IS_ERRORED', false)
      }
   },

   addToCart(context, product) {
      //id, nome, qtd, preco, id_categoria, isLowStock

      context.commit('SET_PRODUCT_TO_CART', product)
   },

   async makeSale() {
      try {
         const result = await api.post('/sales', state.cart)
      } catch (error) {
         console.log(error)
      }
   }

}


const mutations = {
   SET_PRODUCTS_FOR_SALE: (state, productsSale) => { state.productsForSale = productsSale },
   SET_IS_LOADING: (state, loadingStatus) => { state.isLoading = loadingStatus },
   SET_IS_ERRORED: (state, erroredStatus) => { state.isErrored = erroredStatus },
   SET_PRODUCT_TO_CART: (state, product) => { state.cart.unshift(product) },
}

const getters = {
   allProductsForSale: state => state.productsForSale,
   isLoading: state => state.isLoading,
   isErrored: state => state.isErrored,
   productsInCart: state => state.cart
}

export default {
   state,
   actions,
   mutations,
   getters
}