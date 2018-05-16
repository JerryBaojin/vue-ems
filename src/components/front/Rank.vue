<template >
  <section id="ranking"> <span id="ranking_title">我的排行：3</span>
    <section id="ranking_list">

      <section class="box">
        <section title="1" class="col_1">1</section>
        <section class="col_2"><img src="images/head.png"></section>
        <section class="col_3">排行名字</section>
        <section class="col_4">积分：5000</section>
      </section>
      <section class="box">
        <section title="2" class="col_1">2</section>
        <section class="col_2"><img src="images/head.png"></section>
        <section class="col_3">排行名字</section>
        <section class="col_4">积分：3000</section>
      </section>
      <section class="box cur">
        <section title="3" class="col_1">3</section>
        <section class="col_2"><img src="images/head.png"></section>
        <section class="col_3">小萌</section>
        <section class="col_4">积分：2050</section>
      </section>
      <section class="box">
        <section class="col_1">4</section>
        <section class="col_2"><img src="images/head.png"></section>
        <section class="col_3">排行名字</section>
        <section class="col_4">积分：1800</section>
      </section>
      <section class="box">
        <section class="col_1">5</section>
        <section class="col_2"><img src="images/head.png"></section>
        <section class="col_3">排行名字</section>
        <section class="col_4">积分：1200</section>
      </section>
        <section class="box">
        <section class="col_1">6</section>
        <section class="col_2"><img src="images/head.png"></section>
        <section class="col_3">排行名字</section>
        <section class="col_4">积分：1000</section>
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
      }
    },
    methods:{
      toMain(tag){
        this.$router.push({ name: 'main', params: { userId: tag }})
      }
    },
    mounted(){
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
