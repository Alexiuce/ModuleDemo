<template>
  <div id="app">


    <!--需要缓存的页面 : 页面组件的路由中,设置了meta:{keepAlive:true}-->
    <transition name="fade">

      <keep-alive>
        <router-view v-if="$route.meta.keepAlive"/>
      </keep-alive>
    </transition>

    <!-- 不需要缓存的页面-->
    <transition name="fade">

      <router-view v-if="!$route.meta.keepAlive"/>
    </transition>

    <TabBar></TabBar>
  </div>
</template>

<script>

  import TabBar from './Base/TabBar'

  export default {
    name: 'App',
    components: {TabBar}
  }
</script>

<style>

  * {
    margin: 0;
    padding: 0
  }

  ul, li {
    list-style: none;
  }

  a {
    text-decoration: none;
  }

  input, button {
    -webkit-appearance: none
  }

  .content {
    position: fixed;
    width: 100%;
    top: 40px;
    bottom: 50px;
    overflow: auto;
  }

  .fade-enter-active, .fade-leave-active {
    transition: opacity .5s
  }
  .fade-enter, .fade-leave-active {
    opacity: 0
  }

  /*#app {*/
  /*font-family: 'Avenir', Helvetica, Arial, sans-serif;*/
  /*-webkit-font-smoothing: antialiased;*/
  /*-moz-osx-font-smoothing: grayscale;*/
  /*text-align: center;*/
  /*color: #2c3e50;*/
  /*margin-top: 60px;*/

  /*}*/
</style>
