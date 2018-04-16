<template>
    <div class="footer">
      <router-link to="/home">
        <i class="iconfont icon-home"></i>
        <span>首页</span>
      </router-link>
      <router-link to="/list">
        <i class="iconfont icon-list"></i>
        <span>列表</span>
      </router-link>
      <router-link to="/Collection">
        <i class="iconfont icon-collection"></i>
        <span>收藏</span>
      </router-link>
      <router-link to="/add">
        <i class="iconfont icon-add"></i>
        <span>添加</span>
      </router-link>
    </div>
</template>

<script>
    export default {
        name: "TabBar"
    }
</script>

<style scoped>

  .footer{
    position: fixed;
    left: 0px;
    bottom: 0px;
    height: 50px;
    width: 100%;
    display: flex;
    flex-direction: row;
    align-items: center;
    border-top: 1px solid #ccc;
  }

  a{
    display: flex;
    flex-direction: column;
    align-items: center;
    flex: 1;
  }
  a.router-link-active{
    color: red;
  }

</style>
