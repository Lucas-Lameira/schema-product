import api from '../../services/api';

const state = {
   user: null,
   isAuth: false,
   alert: false
}

const actions = {
   async login(context, formData) {
      try {
         const result = await api.post('/login', formData);
         const user = result.data;

         context.commit('SET_LOGGED_IN_USER', user)
         context.commit('SET_IS_AUTHENTICATED', true)

      } catch (error) {
         console.log(error)
         // n precisa verificar status code pois 401 cai aqui
         console.log("oiiii error")
      }
   },

   logout(context) {
      context.commit('SIGN_OUT');
      context.commit('SET_IS_AUTHENTICATED', false);

   }

}

const mutations = {
   SET_LOGGED_IN_USER(state, user) {
      state.user = user
   },

   SET_IS_AUTHENTICATED: (state, authStatus) => state.isAuth = authStatus,
   SIGN_OUT: (state) => state.user = null
}

const getters = {
   getUser: state => state.user,
   isAuth: state => state.isAuth,
   showAlert: state => state.alert
}


export default {
   state,
   actions,
   mutations,
   getters
}