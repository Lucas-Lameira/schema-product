import Vue from 'vue';
import Vuex from 'vuex';

import products from './modules/products';
import sales from './modules/sales';

// load vuex
Vue.use(Vuex);

// create store
export default new Vuex.Store({
  // state in vuex, data in components
  state: {
    user: "true",
    /* categories: null */
  },
  // commit and track state changes (state, payload)
  mutations: {
    /* SET_LOADING(state, loadingStatus){
      state.isLoading = loadingStatus
    },
    SET_USER(state, loggedInUser){
      state.user = loggedInUser
    },
    SET_PRODUCTS(state, productsList){
      state.products
    },
    SET_PRODUCTS_FOR_SALE(state, productsForSaleList){
      state.productsForSale
    }, */
    /*  SET_CATEGORIES(state, categories) {
       state.categories = categories
     } */

  },
  // action should not update store state, call the mutations to do it - actions in vuex, methods in components
  actions: {
    /* loginUser(context, user){
      context.commit('SET_USER', user)
    },

    async fetchAllProducts(context){
      context.commit('SET_LOADING', true)
      try{
        const response = await api.get('/products')
        context.commit('SET_PRODUCTS', response.data)
      }catch(error){
        console.log(error)
      }finally{
        context.commit('SET_LOADING', false)
      }
    }, */

    /* async fetchCategories(context) {
      context.commit('SET_LOADING', true)
      try {
        const response = await api.get('/categories')
        context.commit('SET_CATEGORIES', response.data)
      } catch (error) {
        console.log(error)
      } finally {
        context.commit('SET_LOADING', false)
      }
    } */

  },
  modules: {
    products,
    sales
  },

  // getters in vuex, computed in components
  getters: {

  }
})

// best practice: actions call mutations which updates the state
// context object tem todas as propriedades do vuex store (commit mutations)