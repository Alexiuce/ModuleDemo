import axios from 'axios'

/*设置默认请求路径*/
axios.defaults.baseURL = 'http://localhost:3456'

/* 获取sliders 数据 */

export const getSliders = ()=>{
  return axios.get('/sliders')
};

