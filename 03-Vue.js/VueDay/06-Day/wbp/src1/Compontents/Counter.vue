<template>
  <div>
    计数器:
    <button @click="minus">-</button>
    <br>
    当前:{{$store.state.count}}
    <br>
    计数器:
    <button @click="add">+</button>

    {{$store.getters.number}}
  </div>
</template>

<script>

  import * as Types from '../Store/mutations-types';
  export default {
    name: "Counter",
    data() {
      return {
        count:0,
      }
    },
    methods:{
      add(){
        this.$store.commit(Types.INCREMENT,3)
      },
      minus(){
        this.$store.commit(Types.DECREMENT)
      }
    }
  }
</script>

<style scoped>

</style>
