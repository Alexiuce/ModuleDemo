# 06day

> vue for  the sixth day

## Build Setup

``` bash
# install dependencies
npm install

# serve with hot reload at localhost:8080
npm run dev

# build for production with minification
npm run build

# build for production and view the bundle analyzer report
npm run build --report
```

### 08Day
* 添加热门图书
* 添加Less
* 重构axios ,添加响应拦截器,处理数据


### 09Day
* 添加Loading 效果 (重构api ,合并多个请求)
* 分页面缓存 : 路由元信息
* 下拉加载 :   /page
   默认每次请求5条数据, 后端需要告知是否有更多数据hasMore
* vue-lazyload : 图片懒加载

* 代码分隔:   component:()=>import('../base/Home')


### 10Day
* vuex : 平级组件交互, 跨组件交互 借鉴了 flux redux, vuex只能在vue中使用,可以统一状态数据管理


