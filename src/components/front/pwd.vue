<template >
  <div class="">
    <div id="child_header">
      <div class="goback"><a href="javascript:history.back(-1)"><i></i></a></div>
      <div class="current_location"><span>修改昵称</span></div>
  </div>
  <div class="password_change">


      <div class="psd_li">
          <span>新昵称</span>
          <input type="text" v-model="pwd1" placeholder="请输入1-8位中文字符" maxlength="8" value="">
      </div>

      <div class="psd_li">
          <span>确认昵称</span>
          <input type="text" v-model="pwd2" placeholder="请再次输入昵称" maxlength="20" value="">
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
        uid:JSON.parse(localStorage.getItem('wxUser-jw')).__Uinfos
.uid,
        pwd:'',
        pwd1:'',
        pwd2:''
      }
    },
      methods:{

        submit(){
          if(this.pwd1==''){
            this.$message.error("请填写昵称!");
            return false;
          }
          if(this.pwd1!=this.pwd2){
            this.$message.error("俩次昵称输入不一致!");
            return false;
          }
          this.$axios.post(this.url,{
            action:"updateDirName",
            uid:this.uid,
            pwd1:this.pwd1,
            pwd2:this.pwd2
          }).then(res=>{
            switch (res.data) {
              case 199:
                alert("昵称必须全是中文!");
                break;
              case 198:
                alert("含有敏感字符!");
                break;
              case 101:
                alert("身份检验差错!建议清除缓存重新进入系统!")
                break;
              case 102:
                alert("更新失败,请稍后重试!")
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
