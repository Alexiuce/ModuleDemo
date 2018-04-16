<template>
  <div>
    <NavHeader :back="false">首页</NavHeader>
    Home Page...
  </div>
</template>

<script>

  import NavHeader from '../Base/NavHeader'

  export default {
    name: "Home",
    components:{
      NavHeader
    }
  }
</script>

<style scoped>

</style>
