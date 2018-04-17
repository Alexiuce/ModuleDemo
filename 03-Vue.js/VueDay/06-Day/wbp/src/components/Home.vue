<template>
  <div>
    <NavHeader :back="false">首页</NavHeader>
    <div class="content">
      <ScrollView :swiperSliders="sliders"></ScrollView>
    </div>
  </div>
</template>

<script>

  import {getSliders} from "../Api";
  import NavHeader from '../Base/NavHeader'

  import ScrollView from '../Base/ScrollView'

  export default {
    name: "Home",
     async created(){
       /* 给data 起别名,对象中的属性必须和得到的结果名字一致 */
       const {data} = await getSliders()
       this.sliders =  data
     },
    data(){
      return{
        sliders:[],
      }
    },
    components: {
      NavHeader,
      ScrollView
    }
  }
</script>

<style scoped>

</style>
