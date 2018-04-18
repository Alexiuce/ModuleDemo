<template>

  <div class="header">

    <h3>
    <slot></slot>
    </h3>
    <i v-if="back" class="iconfont icon-fanhui" @click="goback"></i>
  </div>

</template>

<script>
  export default {
    name: "NavHeader",
    props: {
      back:{
        type: Boolean,
        default:false
      }
    },
    methods:{
      goback(){
        this.$router.go(-1)
      }

    }
  }
</script>

<style scoped>

  .header {
    /*position: fixed;*/
    /*left: 0px;*/
    /*top: 0px;*/
    /*width: 100%;*/
    background-color: #afd9ee;
    height: 40px;
    text-align: center;
    line-height: 40px;

  }

  i {
    position: absolute;
    left: 10px;
  }
</style>
