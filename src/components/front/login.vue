<template >
  <div class="">
    <div class="login-box">
		<div class="box-con tran">
			<div class="login-con f-l">
				<div class="form-group">
					<input type="text" v-model="counts" @focus="reset" placeholder="账号"/>
					<span v-if="validate.counts" class="error-notic">不存在该账号!</span>
				</div>
				<div class="form-group">
					<input v-model="pwd" type="password" @focus="reset" placeholder="密码">
					<span v-if="validate.pwd" class="error-notic">密码不正确</span>
				</div>
				<div class="form-group">
					<button type="submit" class="tran pr">
						<div @click="submit()" class="tran">登录</div>
					</button>
				</div>
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
<el-button style="margin-top: 12px;" @click="next">下一步</el-button>
</div>

  </div>
</template>
<script type="text/javascript">
  export default {
    data(){
      return{
        active: 0,
        openid:"",
        url:"api/frontUser.php",
        counts:'',
        pwd:"",
        validate:{
          counts:false,
          pwd:false
        },
      }
    },
    methods:{
      next() {
        if (this.active++ > 2) this.active = 0;
      },
      reset(){
        this.validate={
          counts:false,
          pwd:false
        }
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

      //openid
    }
  }
</script>
<style media="screen">
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
