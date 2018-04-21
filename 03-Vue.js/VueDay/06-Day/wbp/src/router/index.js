import Vue from 'vue'
import Router from 'vue-router'

// 静态导入组件
// import Home from '../components/Home'
// import List from '../components/List'
// import Detail from '../components/Detail'
// import Add from '../components/Add'
// import Collection from '../components/Collection'



Vue.use(Router);

export default new Router({
  routes: [
    {
      path:'/',redirect:'/home'
    },
    {
      path:'/home',

      // component:Home,  // 静态使用组件
      component:()=>import('../components/Home.vue'),
      meta:{
        keepAlive:true
      }
    },
    {
      path:'/add',
      component:()=> import('../components/Add.vue'),
    },
    {
      path:'/list',
      component:()=> import('../components/List.vue'),
    },
    {
      path:'/detail/:tid',
      component:()=> import('../components/Detail.vue'),
      name:"detail"
    },
    {
      path:'/collection',
      component:()=> import('../components/Collection.vue'),
    },

  ]
})
