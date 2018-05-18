<template >
  <section id="ranking"> <span id="ranking_title">我的排行：3</span>
    <section id="ranking_list">

      <section class="box" v-for="(value,index) in datas">
        <section :title="index+1" class="col_1">{{index+1}}</section>
        <section class="col_2"><img :src="value.headImg"></section>
        <section class="col_3">{{value.name}}</section>
        <section class="col_4">积分：{{value.scores}}</section>
      </section>

    </section>
      <router-link to="index" id="play_game">返回答题</router-link>
 </section>
</template>
<script type="text/javascript">
import Wx from './WeixinJssdk';
  export default {
    data(){
      return{
        datas:[]
      }
    },
    methods:{
      toMain(tag){
        this.$router.push({ name: 'main', params: { userId: tag }})
      }
    },
    mounted(){
      this.$axios.post("api/frontUser.php",{
        action:"getRank"
      }).then(res=>{
        this.datas=res.data;
        console.log(this.datas);
      })
      /*
      let dates={
      "title":"甜城味·内江美食地图",
      "desc":"内江史上最全的美食地图,没有之一!",
      "image":"http://weixin.scnjnews.com/foods/share.png",
      "link":"http://weixin.scnjnews.com/foods/#/",
    }
      Wx(dates);
      */
    }
  }
</script>
<style media="screen">

</style>
