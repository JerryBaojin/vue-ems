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
  url:"api/frontUser.php",
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
          this.transitionName = 'slide-left';
        }else{
          this.transitionName = 'slide-right';
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
            phone:''
          }
        },
        methods:{
          checkPhone(){
            this.phone.length<=0?alert("请输入手机号!"):null;
            if (!/^1[3|4|5|6|7|8][0-9]\d{8}$|^\d{8}$/.test(this.phone)) {
              alert("输入的格式错误!");
              return false;
            }
            this.$axios.post(global.url,{
              action:"authPhone",
              phone:this.phone
            }).then(res=>{
              if (res.data) {
                global.userInfo=res.data
              }
              this.$emit('next')
            })
          }
        },
        watch:{
          phone(v){
            global.phone=v;
          }
        },
        mounted(){

        }
      }
      ,step2:{
        template:`
          <div>
          <div class="form-group" id="step2">
            <input type="text"  v-show="userInfo.name !=''" disabled='true' v-model="userInfo.name"   />
            <input type="text"  v-show="userInfo.workUnit !=''" disabled='true' v-model="userInfo.workUnit"   />
            <input type="text" v-model="userInfo.nickname"  placeholder="请输入昵称"/>
          </div>
          <div class="form-group">
            <button type="submit" class="tran pr">
              <div  class="confirm">确认信息</div>
            </button>
          </div>
          </div>
        `,
        data(){
          return{
              userInfo:global.userInfo
          }
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
        this.$axios.post(this.url,{
          action:"auth",
          UID:this.counts,
          pwd:this.pwd,
          openid:this.openid
        }).then(res=>{
            switch (res.data) {
                case 100:
                //未绑定微信
                location.href="http://wx1.scnjnews.com/dati/api/useropenid.php";
                break;
                case 101:
                this.validate.counts=true;
                break;
                case 102:
                this.validate.pwd=true;
                break;
                case 200:
                  this.$message.success("登录成功!");
                  this.$router.push({name:"person",params:{UID:this.counts}})
                  break;
                case 103:
                    this.$message.error("网络错误!");
                  break;
              default:

            }
        }).then(e=>{

        })
      }
    },
    created(){
      let that=this;

      if(this.$route.query.hasOwnProperty('openid')){
          that.openid=this.$route.query.openid;
      }else{
          location.href="http://wx1.scnjnews.com/dati/api/useropenid.php";
      }
    },
    mounted(){

    }
  }
</script>
<style media="screen" scoped>
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
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    margin: auto;
    height: 300px;
  }
</style>
