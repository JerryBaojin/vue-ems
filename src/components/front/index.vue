<template >

    <div class="w640">
    	<div id="h1">
    		<header>
    			<div class="title">
          
    				<h1>每日一题，学习教育</h1>
    			</div>
    		</header>
    		<div class="hm_text" >
    		</div>
    	</div>
    	<div class="hm_text01" ><img src="../../../static/img/text01.png" alt=""></div>
    	<div class="hm_btn">
    		<div class="btn_bg"  @click="toMain('single')" style="">进入每日一题</div>
    		<div class="btn_bg" @click="toMain('muti')">进入测试</div>
    	</div>
    </div>

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
        this.$router.push({ name: 'main', params: { type: tag }})
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
