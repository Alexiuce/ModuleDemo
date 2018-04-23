// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App'
import router from './router'

import VueSwiper from 'vue-awesome-swiper'

import 'swiper/dist/css/swiper.css'

import VueLazyLoad from 'vue-lazyload'


Vue.use(VueLazyLoad, {
  preLoad: 1.3,
  error: 'https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=1987717438,235218657&fm=27&gp=0.jpg',
  loading: 'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1524294523288&di=530527b046b497ec99f0b41d968fd925&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F01ce7e571a50856ac725381283bcb9.gif',
  attempt: 1
});

Vue.use(VueSwiper);

/* 钩子方法: 在进入路由之前,每一次都会执行这个方法,通常用于统一设置或拦截处理 */
router.beforeEach((to,from,next)=>{

  document.title = to.meta.title
  next()

});

/* 在js中使用图片,需要使用import导入或者引用一个线上url */

Vue.config.productionTip = false


/* eslint-disable no-new */
new Vue({
  el: '#app',
  router,
  components: {App},
  template: '<App/>'
})
