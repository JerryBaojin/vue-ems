  <template id="">
      <div class="main">
    <div class="containers">
        <div class="card_title">
          系统通用设置
        </div>
        <blockquote class="tips">
              这里对整个答题系统进行设置;
        </blockquote>
      <el-form :model="ruleForm" :rules="rules" ref="ruleForm" label-width="150px" class="demo-ruleForm">
        <el-form-item label="是否关闭系统">
          <el-radio-group v-model="ruleForm.sysstatus">
            <el-radio label="关闭" value="0"></el-radio>
            <el-radio label="开启" value="1"></el-radio>
          </el-radio-group>
        </el-form-item>


        <el-form-item style="display:none;" label="答题倒计时(秒)" prop="conunter">
          <el-input type="number" v-model.number="ruleForm.conunter"></el-input>
        </el-form-item>
        <el-form-item label="每题答题时间(秒)" prop="perconunter">
          <el-input type="number" v-model.number="ruleForm.perconunter"></el-input>
        </el-form-item>

        <el-form-item label="答题模式">
          <el-radio-group v-model="ruleForm.type" name="">
            <el-radio  label="每日一测" value="single" name="mode"></el-radio >
            <el-radio  label="每周一测" value="week" name="mode"></el-radio >

          </el-radio-group>
        </el-form-item>

        <el-form-item label="活动进行时间段">
          <div class="block">
            <span class="demonstration"></span>
            <el-date-picker
              style="width:223px;"
              v-model="ruleForm.period"
              value-format="timestamp"
              type="datetimerange"
              range-separator="至"
              start-placeholder="开始日期"
              end-placeholder="结束日期">
            </el-date-picker>
          </div>
        </el-form-item>
<!--
        <div class="block">
          <span class="demonstration">默认</span>
          <el-date-picker
            v-model="value4"
            type="datetimerange"
            range-separator="至"
            start-placeholder="开始日期"
            end-placeholder="结束日期">
          </el-date-picker>
        </div>
      -->

        <el-form-item label="用户注册敏感字库">
          <el-input type="textarea" v-model="ruleForm.filter" placeholder="默认敏感字间用英文状态','隔开" ></el-input>
        </el-form-item>
        <el-form-item label="每套题的数目"  prop="timu">
          <el-input type="number" v-model.number="ruleForm.timu"></el-input>
        </el-form-item>
        <el-form-item label="组卷模式" >
          <el-select  v-model="ruleForm.combine" name="">
            <el-option label="随机组卷" value="random" ></el-option>
            <el-option label="指定组卷" value="manmade" ></el-option>
            <el-option label="自选题目" value="manchoose" ></el-option>
          </el-select>
          <el-tooltip content="指定组卷:根据系统设置的每种题型数量，在题库中随机抽取相应的题目。自选题目:使用题库中入选相应的题目." placement="top">
            <el-button>查看说明</el-button>
          </el-tooltip>
        </el-form-item>

        <el-form-item label="题型选择" v-show="ruleForm.combine!='manchoose'">
          <el-select  v-model="ruleForm.qType" name="">

            <el-option v-for="(v,x) in typeLists" :key="x" :label="v" :value="v" checked ></el-option>

          </el-select>
          <el-tooltip content="选择题库中问题已有的分类.若选择默认,则随机抽取组卷." placement="top">
            <el-button>查看说明</el-button>
          </el-tooltip>
        </el-form-item>

        <div :inline="true"  class="demo-form-inline shortPut" v-show=" ruleForm.combine =='manmade' ">
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

        <div :inline="true"  class="demo-form-inline shortPut">
          <el-form-item label="单选题分值" >
            <el-input type="number" v-model.number="ruleForm.ScoresConfig.single"></el-input>
          </el-form-item>
          <el-form-item label="多选题分值">
            <el-input type="number" v-model.number="ruleForm.ScoresConfig.muti"></el-input>
          </el-form-item>
          <el-form-item label="判断题分值">
            <el-input type="number" v-model.number="ruleForm.ScoresConfig.judge"></el-input>
          </el-form-item>
        </div>


        <el-form-item size="large">
            <el-button type="primary" @click="submitForm('ruleForm')">提交</el-button>
            <el-button>取消</el-button>
          </el-form-item>

      </el-form>
    </div>

        <MoudleTest> </MoudleTest>
        <ScoresSetting></ScoresSetting>
  </div>

  </template>
<script>
import MoudleTest from './ModuleTest.vue';
import ScoresSetting from './ScoresSetting.vue';
  export default {
    data() {
      return {
        url: 'api/sys.php',
        editVisible:false,
        typeLists:["默认"],
        ruleForm: {
          period: [],
          timu:0,
          type:'single',
          combine:"",
          conunter: 30,
          filter:"",
          qType:"默认",
          perconunter: 30,
          ScoresConfig:{
            single:2,
            muti:2,
            judge:2
          },
          types: {
                    single:0,
                    muti:0,
                    judge:0
                  },
          sysstatus:"关闭"
        },
        rules: {
          conunter: [
                {required: true, message: '请输入答题倒计时 单位(秒)'},
                { type: 'number', message: '时间必须为数字值'}
          ],

          perconunter: [
            {required: true, message: '请输入每题答题时间 单位(秒)', trigger: 'blur' },
            { type: 'number', message: '时间必须为数字值'}
          ]
        }
      };
    },
    components:{
      MoudleTest,ScoresSetting
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
        res.data.conunter=Number(res.data.conunter);
        res.data.perconunter=Number(res.data.perconunter);
        res.data.ScoresConfig=JSON.parse(res.data.ScoresConfig);
        res.data.types=JSON.parse(res.data.types);

        res.data.period=JSON.parse(res.data.period);



        this.typeLists=JSON.parse(res.data.qTypeList);

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
.main{
  display: flex;
}
.main->.containers{
  flex:1;
margin: 10px;
}
  .containers{
    background-color: white;
    max-width: 33%;
    padding: 2%;
    margin: 10px;

  }
</style>
