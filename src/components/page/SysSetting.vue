  <template id="">
    <div class="containers">
      <el-form :model="ruleForm" :rules="rules" ref="ruleForm" label-width="200px" class="demo-ruleForm">
        <el-form-item v-show="false" label="答题倒计时(秒)" prop="conunter">
          <el-input type="number" v-model.number="ruleForm.conunter"></el-input>
        </el-form-item>

        <el-form-item label="每题答题时间(秒)" prop="perconunter">
          <el-input type="number" v-model.number="ruleForm.perconunter"></el-input>
        </el-form-item>

        <el-form-item  label="答题正确得分" >
          <el-input type="number" v-model.number="ruleForm.scoreR"></el-input>
        </el-form-item>

        <el-form-item  label="答题错误得分" >
          <el-input type="number" v-model.number="ruleForm.scoreW"></el-input>
        </el-form-item>

        <el-form-item label="答题模式" prop="delivery">
          <el-radio v-model="ruleForm.model" label="0">普通模式</el-radio>
          <el-radio v-model="ruleForm.model" label="1">微信发红包模式</el-radio>
        </el-form-item>

        <el-form-item v-if="ruleForm.model=='1'" label="总共发放金额" >
          <el-input type="number" v-model.number="ruleForm.wMoney"></el-input>
        </el-form-item>
        <el-form-item v-if="ruleForm.model=='1'" label="单个红包最大金额" >
          <el-input type="number" v-model.number="ruleForm.wMaxMoney"></el-input>
        </el-form-item>
        <el-form-item v-if="ruleForm.model=='1'" label="达到多少分可获得红包" >
          <el-input type="number" v-model.number="ruleForm.wLowWinner"></el-input>
        </el-form-item>

        <el-form-item label="前台页面分享信息" >
              <el-input type="text" v-model="ruleForm.shareDesc"></el-input>
        </el-form-item>
        <el-form-item label="前台页面分享重定向地址" >
              <el-input type="text" v-model="ruleForm.shareLink"></el-input>
        </el-form-item>
        <el-form-item label="前台页面分享图标" >
              <el-input type="text" v-model="ruleForm.shareImage"></el-input>
        </el-form-item>
        <el-form-item label="是否允许修改已答题目" >
            <el-switch v-model="ruleForm.editAble"></el-switch>
        </el-form-item>

        <el-form-item v-show="false" label="开启套题模式" prop="delivery">
          <el-switch v-model="ruleForm.delivery"></el-switch>
        </el-form-item>

        <el-form-item  label="每套题的数目" v-if="ruleForm.delivery" prop="timu">
          <el-input type="number" v-model.number="ruleForm.timu"></el-input>
        </el-form-item>

        <el-form-item label="组卷模式" v-if="ruleForm.delivery" prop="combine">
          <el-select class="" v-model="ruleForm.combine" name="">
            <el-option value="随机组卷"> </el-option>
            <el-option value="手工组卷"> </el-option>
          </el-select>
        </el-form-item>

        <el-form-item>
          <el-button type="primary" @click="submitForm('ruleForm')">保存</el-button>
          <el-button @click="resetForm('ruleForm')">重置</el-button>
          <el-button @click="editVisible = true">点击修改密码</el-button>
        </el-form-item>
      </el-form>
      <el-form :model="ruleForm2" status-icon :rules="rules2" ref="ruleForm2" label-width="100px" class="demo-ruleForm">
      <el-dialog title="编辑" :visible.sync="editVisible" width="30%">
            <el-form-item label="原密码" prop="pwd">
              <el-input  type="password" v-model="ruleForm2.pwd"></el-input>
            </el-form-item>
            <el-form-item label="密码" prop="pwd1">
              <el-input type="password" v-model="ruleForm2.pwd1" auto-complete="off"></el-input>
            </el-form-item>
            <el-form-item label="确认密码" prop="pwd2">
              <el-input type="password" v-model="ruleForm2.pwd2" auto-complete="off"></el-input>
            </el-form-item>
            <el-form-item>
              <el-button type="primary" @click="submitForm2('ruleForm2')">提交</el-button>
              <el-button @click="editVisible=false">取消</el-button>
            </el-form-item>
          </el-dialog>
      </el-form>
        </div>
  </template>
<script>
  export default {
    data() {
        var validatePass = (rule, value, callback) => {
          this.$axios.post(this.url,{
            action:"checkPWD",
            o:value
          }).then(res=>{
            if(res.data==0){
                 callback(new Error('密码错误!'));
            }else{
               callback();
            }
          }).catch(e=>{
            console.warn(e);
          })
        };
        var validatePass1 = (rule, value, callback) => {
          if (value === '') {
            callback(new Error('请再次输入密码'));
          } else if  (this.ruleForm2.pwd2 !== '') {
           this.$refs.ruleForm2.validateField('pwd2');
             callback();
          } else {
            callback();
          }
        };
       var validatePass2 = (rule, value, callback) => {
         if (value === '') {
           callback(new Error('请再次输入密码'));
         } else if (value !== this.ruleForm2.pwd1) {
           callback(new Error('两次输入密码不一致!'));
         } else {
           callback();
         }
       };
      return {
        url: 'api/sys.php',
        editVisible:false,
        ruleForm: {
          scoreW:0,
          scoreR:0,
          model:0,
          wMoney:0,
          wLowWinner:0,
          wMaxMoney:0,
          timu:0,
          combine:"随机组卷",
          conunter: 30,
          perconunter: 30,
          shareImage:"",
          shareDesc:"",
          shareLink:"",
          editAble:false,
          delivery: false,
        },
        ruleForm2: {
                  pwd: '',
                  pwd1: '',
                  pwd2: ''
                },
        rules: {
          conunter: [
                {required: true, message: '请输入答题倒计时 单位(秒)', trigger: 'blur' },
                { type: 'number', message: '时间必须为数字值'}
          ],
          scoreR:[
            {required: true, message: '请输入大于或等于0的整数', trigger: 'blur' },
            { type: 'number', message: '得分必须为数字值',min: 1, max: 100}
          ],
          scoreW:[
            {required: true, message: '请输入大于或等于0的整数', trigger: 'blur' },
            { type: 'number', message: '得分必须为数字值',min: 1, max: 100}
          ],
          timu: [
            {  required: true, message: '请输入每套题的数目', trigger: 'blur' },
            { type: 'number',min: 1, max: 100, message: '请输入每套题的数目', trigger: 'blur' }
          ],
          perconunter: [
            {required: true, message: '请输入每题答题时间 单位(秒)', trigger: 'blur' },
            { type: 'number', message: '时间必须为数字值'}
          ]
        },
        rules2: {
         pwd: [
            { required: true, message: '请输入密码', trigger: 'blur' },
           { validator: validatePass, trigger: 'blur' }
         ],
         pwd1: [
           { required: true, message: '请输入新密码', trigger: 'blur' },
           { validator: validatePass1, trigger: 'blur' }
         ],
         pwd2: [
           { required: true, validator: validatePass2, trigger: 'blur' }
         ]
       }
      };
    },
    methods: {
      submitForm2(formName) {
        this.$refs[formName].validate((valid) => {
          if (valid) {
            this.$axios.post(this.url,{
                 action:"changePWD",
                 newpwd:this.ruleForm2.pwd2
            }).then(res=>{
              if(res.data==1){
                this.$message.success('修改成功!');
                localStorage.removeItem("ms_username");
                this.$router.push('/login')
              }else{
                this.$message.error('网络传输错误');
                }
            })
          } else {
             this.$message.error('网络传输错误');
             return false;
          }
        });
      },
      submitForm(formName) {
        this.$refs[formName].validate((valid) => {
          if (valid) {
              this.$axios.post(this.url,{
                action:"EditSysConfig",
                data:{...this.ruleForm}
              }).then(res=>{
                if(res.data==1){
                  this.$message.success("修改成功!");
                }else{
                    this.$message.error("修改失败!")
                }
              }).catch(e=>{
              this.$message.error("网络传输错误!")
              })
          } else {
            console.log('error submit!!');
            return false;
          }
        });
      },
      resetForm(formName) {
        this.$refs[formName].resetFields();
      //  this.editVisible=false;
      }
    }
    ,
    mounted(){
      this.$axios.post(
        this.url,{
          action:"getConfig"
        }
      ).then(res=>{
        delete res.data.id;
        res.data.editAble==1?res.data.editAble=true:res.data.editAble=false;
        res.data.conunter=Number(res.data.conunter);
        res.data.perconunter=Number(res.data.perconunter);
        res.data.timu=Number(res.data.timu);
        res.data.delivery=="false"?res.data.delivery=false:res.data.delivery=true;
        this.ruleForm={...res.data};

      }).catch(e=>{
          console.log(e);
      })
    }
  }
</script>
<style scoped>
  .containers{
    background-color: white;
    max-width: 50%;
    padding: 2%;
  }
</style>
