<template >

    <div class="w640" v-cloak>
    	<div id="h1">
    		<header>
    			<div class="title">
    				<h1>内江市创建国家卫生城市</h1>
            <h1>网络知识竞赛</h1>
    			</div>
    		</header>
    		<div class="hm_text" >
    		</div>
    	</div>

    	<div class="hm_text01"  v-if="tag">

      </div>
      <div class="hm_text01 errorDay" v-else>
         仅工作日可答题!

      </div>

    	<div class="hm_btn" v-if="tag">
    		<div class="btn_bg"  v-show="false"   @click="toMain('single')">进入每日一题</div>
          <el-button type="danger" class="enter" @click="toMain('muti')" round>开始答题</el-button>

    	</div>
      <div class="infos">
        <div class="">
          <b>
          活动说明:
        </b>
        </div>
             <br>
        <ul>
          <li>
            1,共计10道题,其中包含单选,多选。
          </li>
          <li>
          2,答对一道题获得10分,累计积分80及其以上就可获得一个0-10元的随机微信红包。</li>
          <li>
            3,每人每天仅限参与一次。
          </li>
        </ul>
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
      getCookie(NameOfCookie){
        if (document.cookie.length > 0) {
        begin = document.cookie.indexOf(NameOfCookie + "=");
        if (begin != -1) {
        begin += NameOfCookie.length + 1;
        end = document.cookie.indexOf(";", begin);
        if (end == -1) end = document.cookie.length;
        return unescape(document.cookie.substring(begin, end));
        }
        }
        return null;
      },
      setCookie(NameOfCookie,value,expiredays){
        var ExpireDate = new Date();
        ExpireDate.setTime(ExpireDate.getTime() + (expiredays * 24 * 3600 * 1000));
        document.cookie = NameOfCookie + "=" + escape(value) + ((expiredays == null) ? "": "; expires=" + ExpireDate.toGMTString());
      },
      getInfo(){
        let __this=this;
        if(this.$route.query.hasOwnProperty('openid') || sessionStorage.getItem("openid") || this.getCookie("dopenid") ){
            this.openid=this.$route.query.openid||sessionStorage.getItem("openid") || this.getCookie("dopenid");
            //存储为session
            sessionStorage.setItem("openid",this.openid);
            this.setCookie("dopenid",this.openid,1);
            let requestAuthUser=async ()=>{
                  let user=this.getDates({action:"qUser",openid:this.openid})
                  user.then(res=>{
                    if(res.errorCode==100){
                      location.href="http://weixin.scnjnews.com/dati/api/useropenid.php";
                    }else if (res.errorCode==204) {
                      __this.answereD=true;

                    }else{
                      sessionStorage.setItem("userInfo",JSON.stringify(res.datas));
                    }
                  });
                  let SysSetting=this.getDates({action:"frontgetConfig"});
                  SysSetting.then(res=>{
                    this.configs=res;
                    let dates={
                    "title":res.shareDesc,
                    "desc":res.shareDesc,
                    "image":res.shareImage,
                    "link":res.shareLink,
                  }
                    Wx(dates);
                    sessionStorage.setItem("syssetting",JSON.stringify(res));
                  })
                }
            requestAuthUser();
        }else{
            location.href="http://weixin.scnjnews.com/dati/api/useropenid.php";
        }
      },
      toMain(tag){
        if (this.answereD) {
          alert("今日你已经答过题了!请明天再来!");
        }else{
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

                      }else{
                        sessionStorage.setItem("userInfo",JSON.stringify(res.datas));
                      }
                    });
                    let SysSetting=this.getDates({action:"frontgetConfig"});
                    SysSetting.then(res=>{
                      this.configs=res;
                      let dates={
                      "title":res.shareDesc,
                      "desc":res.shareDesc,
                      "image":res.shareImage,
                      "link":res.shareLink,
                    }
                      Wx(dates);
                      sessionStorage.setItem("syssetting",JSON.stringify(res));
                        this.$router.push({ name: 'main', params: { type: tag }})
                    })
                  }
              requestAuthUser();
          }else{
              location.href="http://weixin.scnjnews.com/dati/api/useropenid.php";
          }

        }

      }
    },
          created: function () {
                  this.getInfo();

              }
  }
</script>
<style media="screen" scoped>
.infos{
  color: black;
    max-width: 80%;
    font-size: 31px;
    margin-top: 49px;
}
.infos li{
  list-style: none;
}
.title h1{
  font-size: 44px;
}
.enter{
  width: 100%;
      height: 79px;
      font-size: 35px;
      margin: 0 auto;
}
[v-cloak] {
  display: none;
}
  .errorDay{

  font-size: 48px;
  color: red;
  font-weight: bold;
  }
</style>
