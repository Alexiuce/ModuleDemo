
import * as Types from './mutations-types'



const mutations = {
  [Types.INCREMENT](state,delta) {   // state 是自动传入的,代表当前的state
    if (isNaN(parseInt(delta))) return;
    state.count += delta;
  },
  [Types.DECREMENT](state){
    state.count -= 1;
  },
};

export default mutations;
