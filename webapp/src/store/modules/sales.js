import api from '../../services/api';
import Vue from 'vue'

const state = {
   productsForSale: [],
   cart: [],
   isLoading: true,
   isErrored: false,
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
      //cod_product, name, qty, price, id_category, isLowStock, qty_sale


      // check if the product is in the array
      const inCart = state.cart.find(item => item[0] === product[0])

      if (inCart) {
         console.log("exists")
         context.commit('RAISE_PRODUCT_QTY_IN_CART', product)
         context.commit('DECREASE_STOCK', product)
         context.commit('RESET_SALE_QUANTITY', product)
      } else {
         context.commit('SET_PRODUCT_TO_CART', product)
         context.commit('DECREASE_STOCK', product)
         context.commit('RESET_SALE_QUANTITY', product)
      }


   },

   updateProductQauntity(context, args) {

      context.commit('SET_SALE_QUANTITY', args)
   },

   removeFromCart(context, productInCart) {
      context.commit('SET_REMOVE_FROM_CART', productInCart)
      context.commit('INCREASE_STOCK', productInCart)
   },

   async sale() {
      const data = state.cart.map(item => {
         /* const values = [item[0], item[6]] */
         const values = [item[0], 2]
         return values
      })

      console.log(data, "hello")
      try {
         const result = await api.post('/sales', data, { params: { id: 1 } })
         console.log(result)
      } catch (error) {
         console.log(error)
      }
   }

}


const mutations = {
   SET_PRODUCTS_FOR_SALE: (state, productsSale) => { state.productsForSale = productsSale },
   SET_IS_LOADING: (state, loadingStatus) => { state.isLoading = loadingStatus },
   SET_IS_ERRORED: (state, erroredStatus) => { state.isErrored = erroredStatus },
   SET_PRODUCT_TO_CART: (state, product) => { state.cart.push([...product]) },
   SET_REMOVE_FROM_CART(state, productInCart) {
      const index = state.cart.findIndex(item => item[0] === productInCart[0]);

      if (index > -1) {
         state.cart.splice(index, 1)
      }

   },


   DECREASE_STOCK(state, product) {

      console.log(product)

      const index = state.productsForSale.findIndex(item => item[0] == product[0])
      const stock_index = 2;
      const quantity_index = 6;

      if (index > -1) {
         Vue.set(
            state.productsForSale[index],
            stock_index,
            product[stock_index] - product[quantity_index]
         )
      }
   },

   INCREASE_STOCK(state, productInCart) {

      console.log(productInCart)

      const index = state.productsForSale.findIndex(item => item[0] == productInCart[0])
      const stock_index = 2;
      const quantity_index = 6;

      if (index > -1) {
         Vue.set(
            state.productsForSale[index],
            stock_index,
            state.productsForSale[index][stock_index] + productInCart[quantity_index]
         )
      }
   },

   RAISE_PRODUCT_QTY_IN_CART(state, product) {
      const index = state.cart.findIndex(item => item[0] === product[0])
      const quantity_index = 6;

      console.log(state.cart[index])
      console.log(state.cart[index][quantity_index])
      console.log(product[quantity_index])
      console.log(state.cart[index][quantity_index] + product[quantity_index])


      // raise product qty in cart
      if (index > -1) {
         Vue.set(
            state.cart[index],
            quantity_index,
            state.cart[index][quantity_index] + product[quantity_index]
         )
      }

      console.log(state.cart[index])
   },

   SET_SALE_QUANTITY(state, payload) {
      // user o id do produto para acha-lo no array y - id do produto
      const index = state.productsForSale.findIndex(item => payload.id_product === item[0])

      //state.productsForSale[index][6] = payload.quantity
      if (index > -1) {
         Vue.set(
            state.productsForSale[index],
            6,
            payload.quantity
         )
      }

   },

   RESET_SALE_QUANTITY(state, payload) {
      const index = state.productsForSale.findIndex(item => item[0] === payload[0])
      const quantity_index = 6;
      const value = 0;

      console.log(index)

      if (index > -1) {
         Vue.set(
            state.productsForSale[index],
            quantity_index,
            value
         )
      }

   }
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