<template >

    <div class="w640" v-cloak>
    	<div id="h1">
    		<header>
    			<div class="title">
    				<h1>网络知识竞赛</h1>
    			</div>
    		</header>
    		<div class="hm_text" >
    		</div>
    	</div>

    	<div class="hm_text01"  v-if="tag">

      </div>
      <div class="hm_text01 errorDay" v-else>
         仅工作日可答题!

      </div>

    	<div class="hm_btn">
    		 <div class="" v-if="configs.type=='每日一测'">
             <el-button type="danger" class="enter" @click="toMain('single')" round>开始答题</el-button>
         </div>
        <div class="" v-else>
               <el-button type="danger" class="enter" @click="toMain('muti')" round>开始答题</el-button>
        </div>
    	</div>
      <div class="hm_btn">
          <el-button type="danger" class="enter" v-if="taotiExit" @click="toMain('taoti')" round>套题测试</el-button>
      </div>


<el-dialog
  title="请输入验证码"
  :visible.sync="dialogVisible"
  class="dialog"
>
<div class="sourceInput">
  <el-input style="height:53px" v-model="code" placeholder="请输入验证码"></el-input>
  <img :src="validateUrl" alt="" @click="change()">
  <dt>点击图片进行更换图片</dt>
</div>
  <span slot="footer" class="dialog-footer">
    <el-button @click="dialogVisible = false">取 消</el-button>
    <el-button type="primary" @click="checkCode">确 定</el-button>
  </span>
</el-dialog>

    </div>

</template>
<script type="text/javascript">
import Wx from './WeixinJssdk';
  export default {
    data(){
      return{
        uid:null,
        code:"",
        dialogVisible: false,
        validateUrl:"api/validate/output.php?action=seed&x="+new Date().getTime(),
        configs:{
          answereD:false,
          delivery:"false"
        },
        taotiExit:false,
        tag:true,
        params:null
      }
    },
    computed:{

    },
    methods:{
      checkCode(){
          if (this.code=='') {
            alert("请输入验证码");
          }else{
            if (this.params=="taoti") {

              sessionStorage.setItem("syssetting",JSON.stringify(this.$store.state.taoTiconfig));
              if (this.$store.state.taoTiconfig.sysstatus=="关闭") {
                    alert("套题测试已关闭!请稍后再试!");
                    return false;
              }
            }
            let period=null;
            this.params=="taoti"?period=JSON.parse(this.$store.state.taoTiconfig.period):period=JSON.parse(this.configs.period);

            this.$axios.get(`api/validate/output.php?action=check&code=${this.code.toLowerCase()}&params=${this.params}&period=${JSON.stringify(period)}&uid=${this.uid}`).then(res=>{
              if (res.data.validateRes==1) {
                this.code='';
                this.dialogVisible=false;
                if (res.data.isAnswerd) {
                  switch (this.params) {
                    case "single":
                      alert("今日你已经答过题了!请明天再来!");
                      break;
                      case "muti":
                        alert("这周你已经答过题了!请下周再来!");
                        break;
                        case "taoti":
                          alert("你已经答过题了!");
                          break;

                  }

                }else if(this.configs.sysstatus=="关闭"){
                    alert("系统已关闭!请稍后再试!");
                }else{
                  const timeChar=new Date().getTime();


                  if(period==null){
                    this.$router.push({ name: 'main', params: { type: this.params }});
                    return false;
                  }
                  if (timeChar>period[0] ) {
                      if (timeChar<period[1]) {
                        this.$router.push({ name: 'main', params: { type: this.params  }})
                      }else{
                        alert("答题时间已过!");
                      }
                  }else{
                    const d=period[0]
                    alert("答题将于"+this.formatDate(period[0])+"开启!");
                  }

                  }
              }else{

                this.change();
              }
            }).catch(e=>{})
          }
      },
      change(){
        this.code="";
        this.validateUrl="api/validate/output.php?action=seed&x="+new Date().getTime();
      },
      getDates(parmas){
        return new Promise((resolve,reject)=>{
          this.$axios.post("api/sys.php",{
            ...parmas
          }).then((res)=>{
              resolve(res.data)
          }).catch(e=>{
            console.log(e)
          })
        })
      },
      getInfo(){
        let __this=this;
        let userInfo=JSON.parse(localStorage.getItem("wxUser-jw"));
            let requestAuthUser=async ()=>{
                  let SysSetting=await this.getDates({action:"frontgetConfig"});
                    this.configs=SysSetting;
                      this.$store.commit("setScoresConfig",JSON.parse(this.configs.ScoresConfig))
                    let dates={
                    "title":SysSetting.shareDesc,
                    "desc":SysSetting.shareDesc,
                    "image":SysSetting.shareImage,
                    "link":SysSetting.shareLink
                  }
                    Wx(dates);
                    sessionStorage.setItem("syssetting",JSON.stringify(SysSetting));
                  }
            requestAuthUser();
      },
      formatDate(now){
        var date =  new Date(now);
            var y = 1900+date.getYear();
            var m = "0"+(date.getMonth()+1);
            var d = "0"+date.getDate();
            return y+"-"+m.substring(m.length-2,m.length)+"-"+d.substring(d.length-2,d.length);
      },
      toMain(tag){
          this.params=tag;
          this.dialogVisible=true;



        }

    },
          created: function () {
                  this.getInfo();
                              this.uid=JSON.parse(localStorage.getItem("wxUser-jw")).__Uinfos.uid;
                  this.$axios.post("api/sysConfig.php",{
                    action:"getConfig"
                  }).then(res=>{

                            if (res.data.sysstatus=='开启') {
                              this.taotiExit=true;
                            }
                    if (res) {
                      this.$store.commit("setConfig",res.data)
                    }
                  }).catch(e=>{

                  })
              }
  }
</script>
<style media="screen" scoped>
.infos{
  color: black;
    max-width: 80%;
    font-size: 31px;
    margin-top: 49px;
}
.infos li{
  list-style: none;
}
.enter{
  width: 100%;
      height: 79px;
      font-size: 35px;
      margin: 0 auto;
}
[v-cloak] {
  display: none;
}
  .errorDay{
  font-size: 48px;
  color: red;
  font-weight: bold;
  }
.dialog *{
  font-size: 22px;
}
.el-dialog__title{
  font-size: 22px;
}
.sourceInput img{
  height: 68px;
margin: 10px;
}
</style>
