<template >

    <div class="w640" v-cloak>
    	<div id="h1">
    		<header>
    			<div class="title">
    				<h1>每日一题，学习教育</h1>
    			</div>
    		</header>
    		<div class="hm_text" >
    		</div>
    	</div>
    	<div class="hm_text01"  v-if="tag">
        <img  src="../../../static/img/text01.png" alt="">
      </div>
      <div class="hm_text01 errorDay" v-else>
         仅工作日可答题!
      </div>
    	<div class="hm_btn" v-if="tag">
    		<div class="btn_bg"     @click="toMain('single')">进入每日一题</div>
    		<div  v-cloak v-show="configs.delivery!='false'" class="btn_bg" @click="toMain('muti')">进入测试</div>
    	</div>

    </div>

</template>
<script type="text/javascript">
import Wx from './WeixinJssdk';
  export default {
    data(){
      return{
        configs:{
          delivery:"false"
        },
        tag:true
      }
    },
    computed:{

    },
    methods:{
      toMain(tag){
        //查询此人是否今天已经答题过
        this.$axios.post("api/frontUser.php",{
          action:'queryExits',
          type:tag,
          uid:localStorage.getItem("token")
        }).then(res=>{
          if(res.data===1){
            alert("你今天已经答过该类型的题了!");
            this.$router.push({ name: 'person'})
          }else{
            this.$router.push({ name: 'main', params: { type: tag }})
          }
        }).catch(e=>{
          console.log(e);
        })
      }
    },
    mounted(){

      this.$axios.post("api/sys.php",{
        action:"frontgetConfig"
      }).then(res=>{
        this.configs=res.data;
    //    (this.configs.work.result.workmk==1 || this.configs.work.success!=1)?this.tag=true:this.tag=false;
        sessionStorage.setItem("syssetting",JSON.stringify(res.data));

      }).catch(e=>{
        console.log(e);
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
[v-cloak] {
  display: none;
}
  .errorDay{

  font-size: 48px;
  color: red;
  font-weight: bold;
  }
</style>
