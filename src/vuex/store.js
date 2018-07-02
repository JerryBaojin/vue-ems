import Vue from 'vue';
import Vuex from 'vuex';

Vue.use(Vuex);
const store=new Vuex.Store({
    state:{
      loginState:{},
      nowLogin:{
        role:"admin"
      },
      currentTimeChar:'',
      scoresLevel:{
      },
      taoTiconfig:null
    },
    mutations:{
        rePut(state,date){
          state.loginState=date
        },
        setConfig(state,date){
          state.taoTiconfig=date
        },
        setScoresConfig(state,date){
          state.scoresLevel=date
        },
        setCurrentTimeChar(state,date){
            state.currentTimeChar=date
        }
    }
})

export default store;
