<template>
  <div>
    <HeaderView>列表</HeaderView>

    <div class="content">
      <ul>
        <li v-for="book in allBooks">
          <img :src="book.bookCover" alt="">
          <div>
            <h4>{{book.bookName}}</h4>
            <p>{{book.bookInfo}}</p>
            <b>{{book.bookPrice}}</b>
            <button @click="remove(book.bookId)">删除</button>
          </div>
        </li>
      </ul>
    </div>
  </div>
</template>

<script>

  import {getAllBooks,deleteBook} from '../Api'

  import HeaderView from '../Base/NavHeader'
  export default {
    name: "List",
    created(){
      this.fetchAllBooks()
    },
    components:{
      HeaderView
    },
    methods:{

      async fetchAllBooks(){
        this.allBooks = await getAllBooks()
      },
      async remove(bid){
         await deleteBook(bid)
      }
    },
    data(){
      return{
        allBooks:[],
      }
    }
  }
</script>

<style scoped lang="less">


  .content{
    ul{
      padding: 10px;
      li{
        display: flex;
        padding: 10px 0;
        border-bottom: 1px solid #f1f1f1;
        img{
          width: 100px;
          height: 100px;
        }
        h4{
          font-size: 20px;
          line-height: 35px;
        }
        p{
          color: #2a2a2a;
          line-height: 25px;
        }
        b{
          color: red;
        }
        button{
          display: block;
          width: 60px;
          height: 20px;
          background-color: orange;
          border-radius: 10px;
          border: none;
          color: white;
          outline: none;
        }
      }
    }
  }

</style>
