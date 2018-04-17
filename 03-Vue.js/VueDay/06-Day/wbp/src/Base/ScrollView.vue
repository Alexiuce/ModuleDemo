<template>

  <swiper :options="swiperOption">
    <swiper-slide v-for="(slide, index) in swiperSlides" :key="index">I'm Slide {{slide}}</swiper-slide>
    <div class="swiper-pagination" slot="pagination"></div>
  </swiper>

</template>

<script>
    export default {
        name: "ScrollView",
      data(){
          return {
            swiperOption:{
              autoplay: 3000,
              setSwiperSize: true,
              pagination : '.swiper-pagination',
              observeParents:true
            },
            swiperSlides:[1,2,3,4,5,6]
          }
      }
    }
</script>

<style scoped>


</style>
