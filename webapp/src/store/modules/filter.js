import api from '../../services/api';


const store = {
   filter: ""
}

const actions = {
   filterAction(context, payload) {
      console.log(payload)
      console.log()
   }
}

const mutations = {
   FILTER_ACTION(state, payload) {
      console.log(payload)
      console.log(state)
      state.filter = payload
   }
}
const getters = {}

export default {
   store,
   actions,
   mutations,
   getters
}