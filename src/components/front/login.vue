<template >
  <div class="">
    <div class="login-box">
		<div class="box-con tran">
			<div class="login-con f-l">
        <transition  :name="transitionName">
            <component @next="next" :is="currentStep"></component>
        </transition>
				<div class="from-line"></div>
			</div>
		</div>
	</div>
<div class="steps">
  <el-steps :active="active" finish-status="success">
    <el-step title="验证手机号"></el-step>
    <el-step title="确认信息"></el-step>
    <el-step title="登录"></el-step>
  </el-steps>
</div>
  </div>
</template>
<script type="text/javascript">
import Vue from 'vue';

// 使用 Event Bus
const bus = new Vue();
let global={
  userInfo:{
    name:'',
    workUnit:'',
    nickname:''
  },
  openid:null,
  phone:null,
  url:"api/frontUser.php",
  validateCode:null,
  code:null
}
  export default {
    data(){
      return{
        currentStep:"step1",
        transitionName:'',
        active: 0,
        openid:"",
        url:global.url,
        counts:'',
        pwd:"",
        validate:{
          counts:false,
          pwd:false
        },
      }
    },
    watch:{
      currentStep(to, from) {
        //如果to索引大于from索引,判断为前进状态,反之则为后退状态
        if(parseInt(from.slice(4,5)) > parseInt(to.slice(4,5))){
          //设置动画名称
          this.transitionName = 'slide-right';
        }else{
          this.transitionName = 'slide-left';
        }
      }
    },
    components:{
      step1:{
        template:`
          <div>
            <div class="form-group">
    					<input type="number" v-model="phone"  placeholder="请输入手机号"/>
    				</div>
            <div class="form-group">
    					<button type="submit" class="tran pr">
    						<div @click="checkPhone" class="tran">下一步</div>
    					</button>
    				</div>
            </div>
        `,
        data(){
          return{
            validateCode:null,
            phone:''
          }
        },
        methods:{
          checkPhone(){
            //判断当日发送了几次
            //Jslint
              if (this.validateCode) {
                let datas=this.validateCode;
                if(datas.times>=5){
                  if (datas.day==new Date().getDate()) {
                    alert("今日短信发送数量已达到上限，请明天再来!");
                  }else{
                    this.validateCode.times=0;
                    this.sendMsg();
                  }
                }else{
                  this.sendMsg();
                }
              } else{
                this.validateCode={
                  "day":new Date().getDate(),
                  "times":0
                }
                this.sendMsg();
              }
          },
          sendMsg(){
            this.phone.length<=0?alert("请输入手机号!"):null;
            if (!/^1[3|4|5|6|7|8][0-9]\d{8}$|^\d{8}$/.test(this.phone)) {
              alert("输入的格式错误!");
              return false;
            }
            this.$axios.post(global.url,{
              action:"authPhone",
              openid:global.openid,
              phone:this.phone
            }).then(res=>{
              if(res.data.msg<1){
                alert("发送验证码失败!");
                return false;
              }

              if ( res.data.userinfo.dirName && res.data.userinfo.openid ) {
                  let __Uinfos=res.data.userinfo;
                localStorage.setItem("wxUser-jw",JSON.stringify({
                  _openid:global.openid,
                  lastModeTime:new Date().getTime(),
                  __Uinfos:{
                    uid:res.data.userinfo.uid,
                    openid:res.data.userinfo.openid,
                    nickname:res.data.userinfo.dirName,
                    headImg:res.data.userinfo.headImg
                  }
                }))
                this.$router.push({name:"index"});

              }
              if (res.data.userinfo) {

                global.userInfo=res.data.userinfo

              }
              global.code=res.data.code;
               global.phone=this.phone;
              //同步更新localStorage
              this.validateCode.day==new Date().getDate()?this.validateCode.times++:this.validateCode.times=1;

              this.validateCode.day=new Date().getDate();

              localStorage.setItem("validateCode",JSON.stringify(this.validateCode));
              global.validateCode=this.validateCode;

              this.$emit('next');

            })
          }
        },
        watch:{
          phone(v){
            global.phone=v;
          }
        },
        mounted(){
          localStorage.getItem("validateCode")?this.validateCode=JSON.parse(localStorage.getItem("validateCode")):null;
        }
      }
      ,
      step2:{
        template:`
          <div>
          <div class="form-group" id="step2">
            <input type="text"  v-show="userInfo.name" disabled='true' v-model="userInfo.name"   />
            <input type="text"  v-show="userInfo.workUnit" disabled='true' v-model="userInfo.workUnit"   />
            <input type="text"  v-model="userInfo.nickname"  maxlength="8" placeholder="请输入昵称"/>
            <div style="margin-top: 15px;">
              <input placeholder="请输入验证码" maxlength="4" type="number"  v-model="underCheck" />
                <el-button @click="checkPhone" style="position: absolute;width: 82px;right: 30px;height: 68px;line-height:55px;" type="info" :disabled="!reValidate">{{counter}}{{(typeof counter=='number' && counter!=NaN)?'s':''}}</el-button>
            </div>
          </div>
          <div class="form-group">
            <button type="submit" class="tran pr">
              <div @click="confirm" class="confirm">确认信息</div>
            </button>
          </div>
          </div>
        `,
        data(){
          return{
              reValidate:false,
              counter:60,
              code:null,
              userInfo:global.userInfo,
              underCheck:''
          }
        },methods:{
          checkPhone(){
            //判断当日发送了几次
            //Jslint
              if (global.validateCode) {
                let datas=global.validateCode;
                if(datas.times>=5){
                  if (datas.day==new Date().getDate()) {
                    alert("今日短信发送数量已达到上限，请明天再来!");
                  }else{
                    global.validateCode.times=0;
                    this.sendMsg();
                  }
                }else{
                  this.sendMsg();
                }
              } else{
                global.validateCode={
                  "day":new Date().getDate(),
                  "times":0
                }
                this.sendMsg();
              }
          },
           sendMsg(){

              this.$axios.post(global.url,{
                action:"getCode",
                phone:global.phone
              }).then(res=>{
                if(res.data.msg<1){
                  alert("发送验证码失败!");
                  return false;
                }
                global.code=res.data.code
                //同步更新localStorage
                global.validateCode.day==new Date().getDate()?global.validateCode.times++:global.validateCode.times=1;


                global.validateCode.day=new Date().getDate();

                localStorage.setItem("validateCode",JSON.stringify(global.validateCode));
                this.counterStart();
              })
            },
            counterStart(){
              this.code=global.code;
              this.reValidate=false
              this.counter=60
              let timer=setInterval(()=>{
                if (this.counter<=1) {
                  this.counter="重发";
                  this.reValidate=true;
                  clearInterval(timer);
                }else{
                  this.counter--;
                }
              },1000)
            },
            confirm(){

              //判断验证码是否一致
              if (this.underCheck!=global.code) {
                alert("验证码错误!");return;
              }
              //判断中文昵称

              if (this.userInfo.nickname.length>8) {
                this.$message.error("昵称最长只能8个字符!")
                  return false;
              }

              this.$axios.post(global.url,{
                ...this.userInfo,
                phone:global.phone,
                openid:global.openid,
                action:"userRegist"
              }).then(res=>{
                switch (res.data.code) {
                  case 199:
                    this.$message.error("昵称必须全为中文，且最长只能8个字符!");
                    break;
                  case 404:
                    this.$message.error("昵称非法!");
                    break;
                  case 0:
                      this.$message.error("更新信息失败!")
                      break;
                  case 201:
                      this.$message({
                        message:"设置成功!",
                        type:"success",
                      })
                      let __Uinfos=res.data.infos;
                      //保存openid信息
                      localStorage.setItem("wxUser-jw",JSON.stringify({
                        _openid:global.openid,
                        lastModeTime:new Date().getTime(),
                        __Uinfos:__Uinfos
                      }))
                      this.$router.push({name:"index"})
                        break;
                    case 200:
                        this.$message.error("网络错误");
                        break;
                  default:
                      this.$message.error("网络错误，请稍后重试");
                }
              })
            }
        },
        mounted(){
          this.counterStart();
        }
        }

      ,step3:{
        template:`
        <div class="form-group">
					<input type="text" placeholder="请输入手机号"/>
				</div>
        `
      }
    },
    methods:{
      next() {
        if (this.active++ > 2) this.active = 0;
          this.currentStep=`step${this.active+1}`;
      },

      submit(){
        if (this.openid=='') {
            location.href="http://wx1.scnjnews.com/dati/api/useropenid.php";
            return false;
        }

      }
    },
    created(){
      let that=this;

      if(this.$route.query.hasOwnProperty('openid')){
          that.openid=global.openid=this.$route.query.openid;

      }else{
          location.href="http://wx1.scnjnews.com/dati/api/useropenid.php";
      }
    },
    mounted(){

    }
  }
</script>
<style media="screen" scoped>
  .el-step__title{
    font-size: 28px;
  }
  .step2 input{
    margin:10px 0 10px;
  }
    .slide-right-enter-active,
    .slide-right-leave-active,
    .slide-left-enter-active,
    .slide-left-leave-active {
    will-change: transform;
    transition: all 500ms;
    position: absolute;
    }
    .slide-right-enter {
    opacity: 0;
    transform: translate3d(-100%, 0, 0);
    }
    .slide-right-leave-active {
    opacity: 0;
    transform: translate3d(100%, 0, 0);
    }
    .slide-left-enter {
    opacity: 0;
    transform: translate3d(100%, 0, 0);
    }
    .slide-left-leave-active {
    opacity: 0;
    transform: translate3d(-100%, 0, 0);
    }
    .steps{
      position: absolute;
      width: 71%;
      bottom: 0;
      height: 320px;
      margin: 0 auto;
      left: 0;
      right: 0;
    }
    .el-message__content,.el-message__icon{
      font-size: 30px;
    }
    .el-step__title {
      font-size: 30px;
    }
    .error-notic{
      display: block !important;
      color: #ff4e00;
      margin-left: 5%;
      font-size: 30px;
    }
    .login-con{
      width: 560px;
      position: absolute;
      top: -150px;
      left: 0;
      right: 0;
      bottom: 0;
      margin: auto;
      height: 300px;
    }
</style>
