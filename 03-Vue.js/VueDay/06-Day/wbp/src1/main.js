import Vue from 'vue'
import App from './App'

import store from './Store'

const vm = new Vue({
  el: '#app',
  ...App,
  store,   // 注册到实例上,所有组件都会拥有一个属性this.$store

});
