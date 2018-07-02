  <template id="">
    <div class="containers" style="max-width:34%;"> 
      <div class="card_title">
        套题测试
      </div>
      <blockquote class="tips">
        套题测试的配置是独立的，但是若整个系统被关闭了，套题测试同样处于关闭状态!在活动进行时间段里只能进行一次答题
    </blockquote>
      <el-form :model="ruleForm" :rules="rules" ref="ruleForm" label-width="150px" class="demo-ruleForm">
        <el-form-item label="是否关闭套题系统">
          <el-radio-group v-model="ruleForm.sysstatus">
            <el-radio label="关闭" value="0"></el-radio>
            <el-radio label="开启" value="1"></el-radio>
          </el-radio-group>
        </el-form-item>

        <el-form-item label="每题答题时间(秒)" prop="perconunter">
          <el-input type="number" v-model.number="ruleForm.perconunter"></el-input>
        </el-form-item>




        <el-form-item label="活动进行时间段" prop="period">
          <div class="block">
            <span class="demonstration"></span>
            <el-date-picker
              v-model="ruleForm.period"
              value-format="timestamp"
              type="datetimerange"
              range-separator="至"
              start-placeholder="开始日期"
              end-placeholder="结束日期">
            </el-date-picker>
          </div>
        </el-form-item>


        <el-form-item label="每套题的数目"  prop="timu">
          <el-input type="number" v-model.number="ruleForm.timu"></el-input>
        </el-form-item>
        <el-form-item label="组卷模式" >
          <el-select  v-model="ruleForm.combine" name="">
            <el-option label="随机组卷" value="random" ></el-option>
            <el-option label="指定组卷" value="manmade" ></el-option>
          </el-select>
        </el-form-item>

        <el-form-item label="题型选择" >
          <el-select  v-model="ruleForm.qType" name="">

            <el-option v-for="(v,x) in typeLists" :key="x" :label="v['qType']" :value="v['qType']" checked ></el-option>

          </el-select>
        </el-form-item>

        <div :inline="true"  class="demo-form-inline" v-show=" ruleForm.combine =='manmade' ">
          <el-form-item label="单选题数量" >
            <el-input type="number" v-model.number="ruleForm.types.single"></el-input>
          </el-form-item>
          <el-form-item label="多选题数量">
            <el-input type="number" v-model.number="ruleForm.types.muti"></el-input>
          </el-form-item>
          <el-form-item label="判断题数量">
            <el-input type="number" v-model.number="ruleForm.types.judge"></el-input>
          </el-form-item>
        </div>



        <el-form-item size="large">
            <el-button type="primary" @click="submitForm('ruleForm')">提交</el-button>
            <el-button>取消</el-button>
          </el-form-item>

      </el-form>

        </div>
  </template>
<script>

  export default {
    data() {
      return {
        url: 'api/sysConfig.php',
        editVisible:false,
        typeLists:[{qType:"默认"}],
        ruleForm: {
          period: [],
          timu:0,
          type:'single',
          combine:"",
          conunter: 30,

          qType:"默认",
          perconunter: 30,
          types: {
                    single:0,
                    muti:0,
                    judge:0
                  },
          sysstatus:"关闭"
        },
        rules: {
          period: [
            {  required: true, message: '请设置活动进行时间' },
            { type:"array", message: '请设置活动进行时间', trigger: 'blur' }
          ],
          timu: [
            {  required: true, message: '请输入每套题的数目' },
            { type: 'number',min: 1, max: 100, message: '请输入每套题的数目', trigger: 'blur' }
          ],
          perconunter: [
            {required: true, message: '请输入每题答题时间 单位(秒)', trigger: 'blur' },
            { type: 'number', message: '时间必须为数字值'}
          ]
        }
      };
    },

    methods: {
      submitForm(formName) {
        if (this.ruleForm.combine=='manmade') {
          if (this.ruleForm.timu!=(this.ruleForm.types.single+this.ruleForm.types.muti+this.ruleForm.types.judge)) {
            this.$message.error("请核对数目");
            return false;
          }
        }
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

        res.data.perconunter=Number(res.data.perconunter);
        res.data.timu=Number(res.data.timu);
        res.data.types=JSON.parse(res.data.types);
        res.data.period=JSON.parse(res.data.period);
        res.data.qTypeList.map((v,k)=>{
          if(v.qType==''){
            res.data.qTypeList.splice(k,1);
          }
        })

        this.typeLists=this.typeLists.concat(res.data.qTypeList);

        delete res.data.qTypeList;
        this.ruleForm={...res.data};

      }).catch(e=>{
          console.log(e);
      })
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
