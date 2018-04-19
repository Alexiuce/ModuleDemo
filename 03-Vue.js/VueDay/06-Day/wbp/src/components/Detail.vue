<template>
  <div class="detail">
    <HeaderView :back="true">详情</HeaderView>

      <ul>
        <li>
          <label for="bookName">图书名称</label>
          <input type="text" v-model="bookInfo.bookName" id="bookName">
        </li>
        <li>
          <label for="bookPrice">图书价格</label>
          <input type="text" v-model.number="bookInfo.bookPrice" id="bookPrice">
        </li>
        <li>
          <button @click="update">确认修改</button>
        </li>
      </ul>


  </div>
</template>

<script>

  import HeaderView from '../Base/NavHeader'
  import {getBookInfo,updateBookInfo} from '../Api'
  export default {
    name: "Detail",
    created(){
      this.fetchBookInfo()
    },
    watch:{
      $route(){
        this.fetchBookInfo()
      }
    },
    data(){
      return{
        bookInfo:{}
      }
    },
    computed:{
      detailId(){
        return this.$route.params.tid
      }
    },
    components:{
      HeaderView
    },
    methods:{
      async fetchBookInfo(){
        this.bookInfo = await getBookInfo(this.detailId)
      },
      async update(){
        await updateBookInfo(this.detailId,this.bookInfo)
        this.$router.push('/list')
      }
    }
  }
</script>

<style scoped lang="less">

  .detail{
    position: fixed;
    top: 0px;
    bottom: 0px;
    left: 0px;
    right: 0px;
    background-color: #fff;
    z-index: 2;
    ul{
      margin: 50px 10px 0px 10px;
      li{
        label{
          display: block;
          font-size: 20px;
        }
        input{
          margin: 10px 0px;
          height: 25px;
          width: 100%;
        }
        button{
          display: block;
          width: 120px;
          height: 40px;
          background-color: deeppink;
          border-radius: 8px;
          border: none;
          color: white;
          outline: none;
        }
      }
    }
  }

</style>
