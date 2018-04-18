<template>

  <swiper :options="swiperOption">
    <swiper-slide v-for="(slide, index) in swiperSliders" :key="index">
      <img :src="slide" alt="">
    </swiper-slide>

    <div class="swiper-pagination" slot="pagination"></div>
  </swiper>

</template>

<script>
  export default {
    name: "ScrollView",
    props: ['swiperSliders'],
    data() {
      return {
        swiperOption: {
          autoplay: 3000,
          speed:400,
          loop: true,
          setSwiperSize: true,
          pagination:{el:'.swiper-pagination'},
          observeParents: true,
          autoplayDisableOnInteraction: false,
          observer:true
        },
      }
    },

  }
</script>

<style scoped>
  img {
    width: 100%;
  }

</style>
