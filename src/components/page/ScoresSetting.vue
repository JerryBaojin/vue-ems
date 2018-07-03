  <template id="">
    <div class="containers">
      <div class="card_title">
        积分设置
      </div>
      <blockquote class="tips">
        积分设置模块,这里是根据总积分计算的;前三个等级设1-10级，最后一个等级为终极，不再设置细分等级
    </blockquote>
    <el-form :model="numberValidateForm" ref="numberValidateForm" label-width="100px" class="demo-ruleForm">
      <el-form-item
        label="积分区域设置(从低到高)"
        prop="age"

      >
        <el-input type="age" v-model="lvs" auto-complete="off"></el-input>
      </el-form-item>
      <el-form-item
        label="头衔设置"

      >
        <el-input type="age" v-model="lvn" auto-complete="off"></el-input>
      </el-form-item>

      <div class="pic_arrays">

      <div class="pic_holder">
        <div class="label-holder">初级头衔图片:</div>
        <el-upload
          class="avatar-uploader"
          accept="image/*"
          name="lv"
          :action="ajaxUrl+'?x=lv1'"
          :show-file-list="false"
          :on-success="handleAvatarSuccess"
  >
          <img v-if="imageUrl.lv1" :src="imageUrl.lv1" class="avatar">
          <i v-else class="el-icon-plus avatar-uploader-icon"></i>
        </el-upload>
      </div>



      <div class="pic_holder">
        <div class="label-holder">中级头衔图片:</div>
        <el-upload
          class="avatar-uploader"
          accept="image/*"
          name="lv"
          :action="ajaxUrl+'?x=lv2'"
          :show-file-list="false"
          :on-success="handleAvatarSuccess"
  >
          <img v-if="imageUrl.lv2" :src="imageUrl.lv2" class="avatar">
          <i v-else class="el-icon-plus avatar-uploader-icon"></i>
        </el-upload>
      </div>

      <div class="pic_holder">
        <div class="label-holder">高级头衔图片:</div>
        <el-upload
          class="avatar-uploader"
          accept="image/*"
          name="lv"
          :action="ajaxUrl+'?x=lv3'"
          :show-file-list="false"
          :on-success="handleAvatarSuccess"
  >
          <img v-if="imageUrl.lv3" :src="imageUrl.lv3" class="avatar">
          <i v-else class="el-icon-plus avatar-uploader-icon"></i>
        </el-upload>
      </div>

      <div class="pic_holder">
        <div class="label-holder">终级头衔图片:</div>
        <el-upload
          class="avatar-uploader"
          accept="image/*"
          name="lv"
          :action="ajaxUrl+'?x=lv4'"
          :show-file-list="false"
          :on-success="handleAvatarSuccess"
  >
          <img v-if="imageUrl.lv4" :src="imageUrl.lv4" class="avatar">
          <i v-else class="el-icon-plus avatar-uploader-icon"></i>
        </el-upload>
      </div>

</div>
      <el-form-item>
        <el-button type="primary" @click="submitForm('numberValidateForm')">提交</el-button>

      </el-form-item>
      </el-form>
    </div>
  </template>
<script>
export default {
   data() {
     return {
        ajaxUrl:'api/scoresAdmin.php',
        ScoresConfig:null,
        // imageUrl: {
        //   lv1:'',
        //   lv2:'',
        //   lv3:'',
        //   lv4:'',
        // },
        numberValidateForm: {
          age: ''
        }
     };
   },
   computed:{
     imageUrl:{
       get:function(){
         if (!this.ScoresConfig) {
           return {
             lv1:'',
             lv2:'',
             lv3:'',
             lv4:'',
           }
         }else{
                    return JSON.parse(this.ScoresConfig.socres_headPic)
         }

       }
     },
     lvs:{
       get:function(){
         if (this.ScoresConfig) {
          return JSON.parse(this.ScoresConfig.socres_lv).join(",");
         }else{
           return "100,300,600,900";
         }
       },
       set:function(v){
        this.ScoresConfig['socres_lv']=JSON.stringify(v.split(","))
       }
     },
     lvn(){
       if (this.ScoresConfig) {

          return JSON.parse(this.ScoresConfig.socres_name).join(",");
       }else{
         return "初级学童,优秀学生,三好学生,至尊学霸";
       }

     }
   },
   methods: {
     handleAvatarSuccess(v){

       if (typeof v !="object") {
         this.$message.error("上传错误！");
       }else{
         this.imageUrl[v[0]]="api/"+v[1];
    this.ScoresConfig.socres_headPic=JSON.stringify(this.imageUrl);
       }
     },
     submitForm(formName) {
       this.$refs[formName].validate((valid) => {
         this.$axios.post(this.ajaxUrl,{
           action:"setConfig",
           datas:{...this.ScoresConfig}
         }).then(res=>{
          if (res.data==200) {
            this.$message.success("更新成功!")
          }else{
              this.$message.error("更新失败!")
          }

         }).catch(e=>{
           console.log(e);
         })
       });
     }
   },
   mounted(){
     this.$axios.post(this.ajaxUrl,{
       action:"getConfig"
     }).then(res=>{
       this.ScoresConfig=res.data

     }).catch(e=>{
       console.log(e);
     })
   }
 }
</script>
<style scoped>
.pic_arrays{
  display: flex;
}
.pic_holder{
  float: left;
  margin: 1px;
}
.pic_holder:hover{
  cursor:pointer;
}
.label-holder{
  text-align: right;
float: left;
font-size: 14px;
color: #606266;
line-height: 40px;
padding: 0 12px 0 0;
-webkit-box-sizing: border-box;
box-sizing: border-box;
}
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
  .avatar-uploader .el-upload {
  border: 1px dashed #d9d9d9;
  border-radius: 6px;
  cursor: pointer;
  position: relative;
  overflow: hidden;
}
.avatar-uploader .el-upload:hover {
  border-color: #409EFF;
}
.avatar-uploader-icon {
  font-size: 28px;
  color: #8c939d;
  width: 100px;
  height: 100px;
  line-height: 100px;
  text-align: center;
}
.avatar-uploader .el-upload{
  width: 100px !important;
  height: 100px !important;
}
.avatar {
  width: 100px;
  height: 100px;
  display: block;
}
</style>
