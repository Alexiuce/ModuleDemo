import axios from 'axios'

/** 设置默认请求路径 */
axios.defaults.baseURL = 'http://localhost:3456'


/** 设置响应拦截器,可以处理响应数据 */
axios.interceptors.response.use((res)=>{
  return res.data
});

/** 获取sliders 数据 */

export const getSliders = ()=>{
  return axios.get('/sliders')
};

/* 获取热门图书 */
export const getHotBook = ()=>{
  return axios.get('/hot')
}

/** 获取所有图书 */
export const getAllBooks = ()=>{
  return axios.get('/book')
}
/** 删除指定id的图书 */
export const deleteBook = (id)=>{
  return axios.delete(`/book?id=${id}`)
}

/** 获取指定id的图书信息*/
export const getBookInfo = (id)=>{
  return axios.get(`/book?id=${id}`)
}

/** 更新指定id的图书信息
* data: 请求体对象,需要修改的信息
* */
export const updateBookInfo = (id,data)=>{
  return axios.put(`/book?id=${id}`,data)
}

/** 添加图书 */
export const addNewBook = (data)=>{
  return axios.post('/book',data)
}

/** 获取轮播数据和热门图书 */
export const getHomeData = ()=>{
  return axios.all([getSliders(),getHotBook()])
}

/** 获取分页数据 */
export const getPage = (offSet)=>{
  return axios.get(`/page?offSet=${offSet}`)
}
