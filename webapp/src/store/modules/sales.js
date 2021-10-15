import api from '../../services/api';

const state = {
   productsForSale: [],
   isLoading: true,
   isErrored: false
}


const actions = {
   async fetchProductsForSale(context) {
      try {
         const result = await api.get('/sales');
         console.log(result.data)
         context.commit('setProductsForSale', result.data)
      } catch (error) {
         console.log(error)
         context.commit('setIsErrored', true)
      } finally {
         context.commit('setIsLoading', false)
      }
   },
}


const mutations = {
   setProductsForSale: (state, products) => { state.productsForSale = products },
   setIsLoading: (state, loadingStatus) => { state.isLoading = loadingStatus },
   setIsErrored: (state, erroredStatus) => { state.isErrored = erroredStatus }
}

const getters = {
   allProductsForSale: (state) => { state.productsForSale },
   isLoading: (state) => { state.isLoading },
   isErrored: (state) => { state.isErrored }
}

export default {
   state,
   actions,
   mutations,
   getters
}