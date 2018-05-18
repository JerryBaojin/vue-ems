<template >
  <div id="answer" class="w640">
  			<header>
  				<div class="hm_icon">
  					<span class="f-l">
              <router-link to="person">
    						<img src="http://thirdwx.qlogo.cn/mmopen/vi_32/B9eDDgEoS90sHsmFEicczSyHE7KjR3IE4dH7mUEicswWSotOYFMgeMSXiaqY8scXruzCzaaRFbmzccwDQaBmRUSaA/132" style="" />
    						<h2>小萌<br><small>积分：2050</small></h2>
              </router-link>
  					</span>
  					<span class="f-r">
              <router-link to="Rank"><img src="../../../static/img/ranking.png" alt=""></router-link>
  			   
  					</span>
  				</div>
  				<div class="title">
  					<h1>每日一题，学习教育</h1>
  				</div>
  			</header>
        <v-questions :msg="type"></v-questions>

  </div>
</template>
<script type="text/javascript">
import Wx from './WeixinJssdk';
import vQuestions from './QuestionM';
  export default {
    data(){
      return{

      }
    },
    components:{
      vQuestions
    },
    computed:{
      type(){
          console.log(this.$route.params)
        return this.$route.params.type
      }
    },
    mounted(){
      if(this.$route.params.hasOwnProperty("type")){

      }else{
        this.$router.push("/front/index");
      }

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
