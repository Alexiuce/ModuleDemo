const vm = new Vue({
  el: '#app',
  data: {
    newTodo: '',
    todos:[
      {
        isSelected:false,
        title: '准项目'
      },
      {
        isSelected:false,
        title: '开项目'
      },
      {
        isSelected:false,
        title: '准流程'
      }
    ]
  },



  methods:{
    addList(){
        if (this.newTodo.length < 1){return}
        let obj = {isSelected:false,title:this.newTodo}
        this.todos.unshift(obj)
        this.newTodo = ''
    },
    delList(target){

      this.todos = this.todos.filter(item=>item!==target)

    }
  },
  computed:{
    count(){
      return this.todos.reduce((prev,next)=>{
        if (next.isSelected) return prev;
        return prev + 1
      },0)
    }
  },
  watch: {
    todos: {
      handler(){
        alert('hel');
      },
      deep:true
    }
  }


});