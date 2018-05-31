<template >

    <div class="w640" v-cloak>
    	<div id="h1">
    		<header>
    			<div class="title">
    				<h1>网络知识竞赛</h1>
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
    		<div class="btn_bg"  v-show="false"   @click="toMain('single')">进入每日一题</div>
    		<div  v-cloak class="btn_bg" @click="toMain('muti')">进入测试</div>
    	</div>

    </div>

</template>
<script type="text/javascript">
import Wx from './WeixinJssdk';
  export default {
    data(){
      return{
        configs:{
          answereD:false,
          delivery:"false"
        },
        tag:true
      }
    },
    computed:{

    },
    methods:{
      getDates(parmas){
        return new Promise((resolve,reject)=>{
          this.$axios.post("api/sys.php",{
            ...parmas
          }).then((res)=>{
              resolve(res.data)
          }).catch(e=>{
            console.log(e)
          })
        })
      },
      toMain(tag){
        if (this.answereD) {
          alert("今日你已经答过题了!请明天再来!");
        }else{
          this.$router.push({ name: 'main', params: { type: tag }})
        }

      }
    },

    mounted(){
      let __this=this;
      if(this.$route.query.hasOwnProperty('openid') || sessionStorage.getItem("openid") ){
          this.openid=this.$route.query.openid||sessionStorage.getItem("openid");
          //存储为session
          sessionStorage.setItem("openid",this.openid);
          let requestAuthUser=async ()=>{
                let user=this.getDates({action:"qUser",openid:this.openid})
                user.then(res=>{
                  if(res.errorCode==100){
                    location.href="http://weixin.scnjnews.com/dati/api/useropenid.php";
                  }else if (res.errorCode==204) {
                    __this.answereD=true;
                    alert("今日你已经答过题了!请明天再来!");
                  }else{
                    sessionStorage.setItem("userInfo",JSON.stringify(res.datas));
                  }
                });
                let SysSetting=this.getDates({action:"frontgetConfig"});
                SysSetting.then(res=>{
                  this.configs=res;
                  sessionStorage.setItem("syssetting",JSON.stringify(res));
                })
              }
          requestAuthUser();

      }else{

          location.href="http://weixin.scnjnews.com/dati/api/useropenid.php";
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
[v-cloak] {
  display: none;
}
  .errorDay{

  font-size: 48px;
  color: red;
  font-weight: bold;
  }
</style>
