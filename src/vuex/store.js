import Vue from 'vue';
import Vuex from 'vuex';

Vue.use(Vuex);
const store=new Vuex.Store({
    state:{
      loginState:{},
      nowLogin:{
        role:"admin"
      }
    },
    mutations:{
        rePut(state,date){
          state.loginState=date
        }
    }
})

export default store;
