<template>
  <div>
    <HeaderView>列表</HeaderView>

    <div class="content" ref="scroll" @scroll="autoLoadMore">
      <ul>
        <router-link v-for="(book,index) in allBooks" :to="{name:'detail',params:{tid:book.bookId}}" :key="index"
                     tag="li">
          <img :src="book.bookCover" alt="">
          <div>
            <h4>{{book.bookName}}</h4>
            <p>{{book.bookInfo}}</p>
            <b>{{book.bookPrice}}</b>
            <button @click.stop="remove(book.bookId)">删除</button>
          </div>
        </router-link>
      </ul>
      <div @click="getMore" class="loadMore">加载更多</div>
    </div>
  </div>
</template>

<script>

  import {getPage, deleteBook} from '../Api'

  import HeaderView from '../Base/NavHeader'

  export default {
    name: "List",
    created() {
      this.fetchBooks()
    },
    components: {
      HeaderView
    },
    mounted() {
      const scroll = this.$refs.scroll // 获取拖拽元素
      const top = scroll.offsetTop   // 顶部偏移
      let detalY = 0  // 设置y值变化量,默认0
      console.log(top);
      // 添加事件监听
      scroll.addEventListener('touchstart', (e) => {
        //
        if (scroll.scrollTop != 0 || scroll.offsetTop != top) return;

        // 获取触摸y值
        const touchY = e.touches[0].pageY;
        console.log(touchY);

        const moveFun = (e) => {
          const moveCurentY = e.touches[0].pageY
          detalY = moveCurentY - touchY;  // 移动距离

          if (detalY > 0) {  // 向下拖动
            if (detalY <= 50) {
              scroll.style.top = detalY + top + 'px';
            } else {
              detalY = 50;
              scroll.style.top = top + 50 + 'px';
            }

          } else {
            scroll.removeEventListener('touchMove', moveFun)
            scroll.removeEventListener('touchEnd', endFun)
          }

        };

        const endFun = (e) => {
          clearTimeout(this.timer1) /** 先清理之前的定时器 */
          // 恢复下拉前位置
          this.timer1 = setInterval(() => {
            detalY --;
            scroll.style.top = top + detalY + 'px';
            if (detalY <= 0){
              detalY = 0;
              clearTimeout(this.timer1)
              scroll.removeEventListener('touchmove', moveFun);
              scroll.removeEventListener('touchend', endFun);
            }

          }, 1);
          // 判断是否需要加载数据
          if (detalY == 50) {
            // 请求数据
          }

        };


        scroll.addEventListener('touchmove', moveFun);
        scroll.addEventListener('touchend', endFun);


      })
    },
    methods: {

      /* 自动加载更多*/
      autoLoadMore() {

        clearTimeout(this.timer)
        this.timer = setTimeout(() => {
          const {scrollTop/*卷起高度*/, clientHeight/*可见高度*/, scrollHeight/*总体高度*/} = this.$refs.scroll
          if (scrollTop + clientHeight + 20 >= scrollHeight) {
            this.getMore()
          }

        }, 50)

      },

      async fetchBooks() {
        if (this.hasMore && !this.isLoading) {
          this.isLoading = this
          const {hasMore, data} = await getPage(this.offSet)
          this.hasMore = hasMore
          this.allBooks = [...this.allBooks, ...data]
          this.offSet = this.allBooks.length
          this.isLoading = false
        }
      },
      async remove(bid) {
        await deleteBook(bid)
        this.allBooks = this.allBooks.filter((item) => item.bookId != bid)
      },
      getMore() {
        this.fetchBooks()
      }
    },
    data() {
      return {
        allBooks: [],
        offSet: 0,  // 分页请求偏移量
        hasMore: true,  // 是否可以加载更多
        isLoading: false,
      }
    }
  }
</script>

<style scoped lang="less">


  .content {
    ul {
      padding: 10px;
      li {
        display: flex;
        padding: 10px 0;
        border-bottom: 1px solid #f1f1f1;
        img {
          width: 100px;
          height: 100px;
        }
        h4 {
          font-size: 20px;
          line-height: 35px;
        }
        p {
          color: #2a2a2a;
          line-height: 25px;
        }
        b {
          color: red;
        }
        button {
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
    .loadMore {
      margin: 10px;
      background-color: #2afedd;
      height: 30px;
      line-height: 30px;
      text-align: center;
      font-size: 20px;
    }
  }

</style>
