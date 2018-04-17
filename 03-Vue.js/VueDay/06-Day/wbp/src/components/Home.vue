<template>
  <div>
    <NavHeader :back="false">首页</NavHeader>
    <div class="content">
      <ScrollView></ScrollView>
    </div>
  </div>
</template>

<script>

  import NavHeader from '../Base/NavHeader'

  import ScrollView from '../Base/ScrollView'

  export default {
    name: "Home",
    components: {
      NavHeader,
      ScrollView
    }
  }
</script>

<style scoped>

</style>
