<template>
    <div class="login-wrap">
        <div class="ms-title">答题后台管理系统</div>
        <div class="ms-login">
            <el-form :model="ruleForm" :rules="rules" ref="ruleForm" label-width="0px" class="demo-ruleForm">
                <el-form-item prop="username">
                    <el-input v-model="ruleForm.username" placeholder="手机号"></el-input>
                </el-form-item>

                <el-form-item prop="password">
                    <el-input type="number" placeholder="验证码" maxlength="4" v-model="ruleForm.password" @keyup.enter.native="submitForm('ruleForm')">
                       <template  slot="append" ><span @click="getCode" class="controllArea">{{validate.code==null?'获取验证码':`${validate.counter}s`}}</span></template>
                    </el-input>

                </el-form-item>
                <div class="login-btn">
                    <el-button type="primary" @click="submitForm('ruleForm')">登录</el-button>
                </div>
            </el-form>
        </div>
    </div>
</template>

<script>
    export default {
        data: function(){
          let validateUserName=(rule,value,callback)=>{
            if (value === '') {
              callback(new Error('请输入手机号'));
             } else {

               callback();
             }
          }
          let validateUserPwd=(rule,value,callback)=>{
            if (value === '') {
              callback(new Error('请输入密码'));
             } else {

               callback();
             }
          }
            return {
              validate:{
                code:null,
                counter:60
              },
                ruleForm: {
                    username: '',
                    password: ''
                },
                rules: {
                    username: [
                        { required: true, message: '请输入手机号', trigger: 'blur' }
                    ],
                    password: [
                        { required: true, message: '请输入验证码', trigger: 'blur' }
                    ]
                }
            }
        },
        methods: {
          counterStart(){
            let his=localStorage.getItem("adminLoginCounter");
            his?this.validate.counter=his:this.validate.counter=60;
            let timer=setInterval(()=>{
              if (this.validate.counter<=1) {
                this.validate.code=null;
                localStorage.removeItem("adminLoginCounter");
                clearInterval(timer);
              }else{
                      localStorage.setItem("adminLoginCounter",this.validate.counter);
                this.validate.counter--;
              }
            },1000)
          },
          getCode(){

            if (this.code) {
              return false;
            }

            if (!this.ruleForm.username || !/^1[3|4|5|6|7|8][0-9]\d{8}$|^\d{8}$/.test(this.ruleForm.username)) {
              this.$message.error("请输入正确的手机号!");
              return false;
            }

            this.$axios.post("api/frontUser.php",{
              action:"AdmingetCode",
              phone:this.ruleForm.username
            }).then(res=>{
              if (res.data==403) {
                alert("用户不存在，请检查手机号!")
                return false;
              }
              if(res.data.msg<1){
                alert("发送验证码失败!");
                return false;
              }
              this.validate.code=res.data.code;

              this.counterStart();
            })
          },
            submitForm(formName) {
                this.$refs[formName].validate((valid) => {
                    if (valid) {
                        this.$axios.post('api/sys.php',{
                          action:"login",
                          data:{...this.ruleForm}
                        }).then(res=>{
                          switch (res.data.code) {
                            case 403:
                              this.$message.error("验证码错误!");
                              break;
                            case 404:
                              this.$message.error("未找到该用户信息!");
                            break;
                            case 500:
                                this.$message.error("请重新获取验证码!");
                              break;
                            case 200:
                            localStorage.removeItem("adminLoginCounter");
                            localStorage.setItem('counterNumber',res.data.counterNumber);
                            localStorage.setItem('ms_username',res.data.info.counter);
                            localStorage.setItem('login_time',res.data.login_time);
                            localStorage.setItem('role',res.data.info.role);
                            this.$router.push('/admin/dashboard');
                            break;
                            default:

                          }

                        }).catch(e=>{
                          console.log(e);
                        })


                    } else {
                        console.log('error submit!!');
                        return false;
                    }
                });
            }
        }
        ,mounted(){
              if (localStorage.getItem("adminLoginCounter")) {
                this.validate.code=true;
              this.counterStart();
              }
        }
    }
</script>

<style scoped>
.controllArea:hover{
  cursor: pointer !important;
}
.el-select .el-input {
  width: 130px;
}
    .login-wrap{
        position: relative;
        width:100%;
        height:100%;
    }
    .ms-title{
        position: absolute;
        top:50%;
        width:100%;
        margin-top: -230px;
        text-align: center;
        font-size:30px;
        color: #fff;

    }
    .ms-login{
        position: absolute;
        left:50%;
        top:50%;
        width:300px;
        height:160px;
        margin:-150px 0 0 -190px;
        padding:40px;
        border-radius: 5px;
        background: #fff;
    }
    .login-btn{
        text-align: center;
    }
    .login-btn button{
        width:100%;
        height:36px;
    }
</style>
