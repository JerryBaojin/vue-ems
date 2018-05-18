<template >
  <div class="">
    <div id="child_header">
      <div class="goback"><a href="javascript:history.back(-1)"><i></i></a></div>
      <div class="current_location"><span>修改密码</span></div>
  </div>
  <div class="password_change">
      <div class="psd_li">
          <span>原密码</span>
          <input type="password" v-model="pwd" @blur="checkPwd" placeholder="请输入原密码" maxlength="20" value="">
      </div>

      <div class="psd_li">
          <span>新密码</span>
          <input type="password" v-model="pwd1" placeholder="请输入4~20位密码" maxlength="20" value="">
      </div>

      <div class="psd_li">
          <span>确认密码</span>
          <input type="password" v-model="pwd2" placeholder="请再次输入密码" maxlength="20" value="">
      </div>
      <div class="submit">
          <el-button @click="submit"  type="danger">提交</el-button>
      </div>

  </div>
  </div>

</template>

<script type="text/javascript">
  export default {
    data(){
      return{
        url:"api/frontUser.php",
        uid:localStorage.getItem("token"),
        pwd:'',
        pwd1:'',
        pwd2:''
      }
    },
      methods:{
        checkPwd(){
          if(this.pwd==''){
            this.$message.error("请填写原密码!");
            return false;
          }
          this.$axios.post(this.url,{
            action:"checkpwd",
            pwd:this.pwd,
            uid:this.uid
          }).then(res=>{
            if(res.data!==100){
                this.$message.error("原密码错误!");
            }
          }).catch(e=>{
            console.log(e);
          })

        },
        submit(){
          if(this.pwd==''){
            this.$message.error("请填写原密码!");
            return false;
          }
          if(this.pwd1!=this.pwd2){
            this.$message.error("俩次密码输入不一致!");
            return false;
          }
          this.$axios.post(this.url,{
            action:"updatepwd",
            pwd:this.pwd,
            uid:this.uid,
            pwd1:this.pwd1,
            pwd2:this.pwd2
          }).then(res=>{
            console.log(res);
            switch (res.data) {
              case 101:
                this.$message.error("原密码错误!");
                break;
              case 102:
                this.$message.error("更新失败!");
                break;
              case 200:
                this.$message.success("修改成功!");
                localStorage.removeItem("token");
                localStorage.removeItem(this.uid);
                this.$router.push({path:"/front/login"})
                break;

              default:

            }
          }).catch(e=>{
            console.log(e);
          })
        }
      },
      mounted(){

      }


  }

</script>
<style media="screen">
.el-message__content,.el-message__icon{
  font-size: 30px;
}
  .submit{
    text-align: center;
    margin-top: 35px;
  }
  .submit button{
    font-size: 30px;
    width: 80%;
  }
</style>
