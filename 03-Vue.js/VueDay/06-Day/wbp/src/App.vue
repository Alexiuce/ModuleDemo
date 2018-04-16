<template>
  <div id="app">

    <router-view/>
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

  /*#app {*/
  /*font-family: 'Avenir', Helvetica, Arial, sans-serif;*/
  /*-webkit-font-smoothing: antialiased;*/
  /*-moz-osx-font-smoothing: grayscale;*/
  /*text-align: center;*/
  /*color: #2c3e50;*/
  /*margin-top: 60px;*/

  /*}*/
</style>
