import Vue from 'vue'
import Vuex from 'vuex'
import mutations from './mutations'

Vue.use(Vuex);

const state = {count: 0};

/* 相当于计算属性 */
const getters = {

  number: (state)=>{
    return state.count%2;
  }

};

export default new Vuex.Store({
  state,
  mutations,
  getters,
  strict: true, //只能通过mutation(不支持异步,异步需要使用action) 修改状态
});


