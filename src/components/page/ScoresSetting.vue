  <template id="">
    <div class="containers">
      <div class="card_title">
        积分设置
      </div>
      <blockquote class="tips">
        积分设置模块,这里是根据总积分计算的;
    </blockquote>
    <el-form :model="numberValidateForm" ref="numberValidateForm" label-width="100px" class="demo-ruleForm">
      <el-form-item
        label="年龄"
        prop="age"
        :rules="[
          { required: true, message: '年龄不能为空'},
          { type: 'number', message: '年龄必须为数字值'}
        ]"
      >
        <el-input type="age" v-model.number="numberValidateForm.age" auto-complete="off"></el-input>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="submitForm('numberValidateForm')">提交</el-button>
        <el-button @click="resetForm('numberValidateForm')">重置</el-button>
      </el-form-item>
      </el-form>
    </div>
  </template>
<script>
export default {
   data() {
     return {
       numberValidateForm: {
         age: ''
       }
     };
   },
   methods: {
     submitForm(formName) {
       this.$refs[formName].validate((valid) => {
         if (valid) {
           alert('submit!');
         } else {
           console.log('error submit!!');
           return false;
         }
       });
     },
     resetForm(formName) {
       this.$refs[formName].resetFields();
     }
   }
 }
</script>
<style scoped>
.tips{
border-left: 2px solid #009A61;
background: #F6F6F6;
color: #555;
font-size: 1em;
margin: 1em;
padding: 1em;
}
.card_title{
  text-align: center;
  margin-bottom: 20px;
  font-size: 28px;
}
  .containers{
    background-color: white;
    max-width: 50%;
    padding: 2%;
  }
</style>
