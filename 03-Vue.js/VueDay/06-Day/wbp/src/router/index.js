import Vue from 'vue'
import Router from 'vue-router'


import Home from '../components/Home'
import List from '../components/List'
import Detail from '../components/Detail'
import Add from '../components/Add'
import Collection from '../components/Collection'



Vue.use(Router);

export default new Router({
  routes: [
    {
      path:'/',redirect:'/home'
    },
    {
      path:'/home',
      component:Home,
      meta:{
        keepAlive:true
      }
    },
    {path:'/add',component:Add},
    {path:'/list',component:List},
    {path:'/detail/:tid',component:Detail, name:"detail"},
    {path:'/collection',component:Collection},

  ]
})
