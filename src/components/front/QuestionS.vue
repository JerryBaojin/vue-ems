<template id="">
    <div class="" >
      <div class="count">进度{{current+1}}/{{questions.length}}</div>
            <ul class="countdown">
              <li> <span class="seconds">{{totalTimesLeft}}</span></li>
            </ul>
            <div  v-show="!isLast">
              <div v-for="(value,index) in questions" v-show="index==current" :id="'block'+index">
                <div id="q1">
                  <div class="content">
                    <p class="subject_t">{{index+1}}、{{value.question}}{{value.correctType.length>1?'(多选)':null}}</p>
                    <p v-for="(items,key) in value.answer">
                      <span><input :id="'rd'+value.id+key" :disabled="!abledToClick"  :name="'rd'+index" :data-answer="items[0]" :data-pid="key+1" :type="value.type" ></span>
                      <label :for="'rd'+value.id+key" >{{key==0?"A":key==1?"B":"C"}}:{{items[1]}}</label>
                    </p>
                  <div class="enter_btn">
                    <a id="b1" @click="sub(index)" v-if="doneGrade.length==0" disabled="true" href="javascript:void(0);">确定</a>
                  </div>
                </div>
                <div id="a1" v-show="checkResult.toggle">
                  <p>正确答案:{{value.correctIndex}}</p>
                </div>
                  </div>
              </div>
            </div>
            <div v-show="isLast" class="content">
                  <div class="finaly">
                    <div class="">
                      恭喜你获得{{scores}}分!
                    </div>
                    <div v-if="weChat">
                      获得{{wxhb}}元的现金红包!
                    </div>

                  </div>
                      <el-button size="medium" v-for="(v,i) in doneGrade" :key="i" :type="v.res==1?'success':'danger'" @click="checkQuestion(i)">{{i+1}}</el-button>
            </div>
              <i v-show="checkResult.isNow" :class="checkResult.result?'el-icon-success ico1':'el-icon-error ico2'" ></i>
</div>
</template>
<script type="text/javascript">
export default {
  data(){
    return{
        url:"api/frontUser.php",
        questions:[],
        current:0,
        qid:[],

        config:{},
        checkResult:{
          isNow:false,
          result:false,
          toggle:false
        },
        weChat:false,
        isLast:false,
        abledToClick:true,
        timer:null,
        correctA:[],
        doneGrade:[],
        totalTimesLeft:0,
        wxhb:0,
        isPreview:false
    }
  },
  computed:{
    scores(){
        return this.doneGrade.filter((v)=>v.res==1).length*JSON.parse(sessionStorage.getItem('syssetting')).scoreR;
    },
    weChat(){
      if (JSON.parse(sessionStorage.getItem('syssetting')).model==1) {
        return true
      }else{
        return false;
      }
    }
  },
  watch:{
    current(val){
      this.isLast=false;
      val+1==this.questions.length?val=-1:null;
      this.$emit('currentNow',val);//upup
    }
  },
  methods:{
    __loopPage(){
      let i=this.current;
      let result=false;
      this.$emit('currentNow',i+1);//upup
      this.doneGrade[i].res==0?result=false:result=true;
      this.checkResult={
        isNow:true,
        result,
        toggle:!result
      }
    },
    checkQuestion(i){
      this.isPreview=true;
      this.current=i;
      this.__loopPage();
      this.$emit("disableEdit",true);
    },
    chooseQes(action,index){
      index=index||this.current;
      if (!this.isPreview) {
        if(action=="next"){
          let  ops=document.querySelectorAll(`#block${index} input:checked`);
          if (ops.length==0) {
            alert("请选择!");
            return false;
          }else{
            this.current++;
          }
        }else{
          if(index-1<0){
            alert("已经是第一道题了!")
          }else{
            this.current--;
          }
        }
      }else{
        //翻页动作
        action=="next"?this.current++:this.current--;
            this.__loopPage();
      }
    },
    syncDates(){
      let that=this;
      let userAnser=new Array();
      //count per question's answer
      for (let i = 0; i < this.questions.length; i++) {
          let  ops=document.querySelectorAll(`#block${i} input:checked`);
          let __nowAnswers=[];
          let res=0;
          for(let k=0;k<ops.length;k++){
            __nowAnswers.push(ops[k].dataset.answer);
          }
          this.questions[i].correctType.join("")==__nowAnswers.sort().join("")?res=1:res=0;
          this.doneGrade.push({
            index:i,
            choosed:__nowAnswers.sort(),
            res,
            correct:this.questions[i].correctType
          })
      }

      this.$emit("disableEdit",false);//禁止step
      this.isLast=true;
      this.totalTimesLeft='';
      clearInterval(this.timer);
      const loading = this.$loading({
         lock: true,
         text: '数据处理中',
         spinner: 'el-icon-loading',
         background: 'rgba(0, 0, 0, 0.7)'
       });
      this.$axios.post(this.url,{
        action:"saveQinfos",
        uid:sessionStorage.getItem("openid"),
        datas:this.doneGrade
      }).then(res=>{

        switch (res.data.errorCode) {
          case 403:
              alert("非法答题!");
              location.href="http://weixin.scnjnews.com/dati/api/useropenid.php";
            break;
          case 204:
              alert("很抱歉,所有红包已经发放完了!");
            break;
          case 200:
              res.data.money==0?this.weChat=false:this.weChat=true;

              this.wxhb=res.data.money
            break;
            case 203:
                  alert("你今天已经参与过答题了!");
              break;
          case 500:
                alert("与服务器失去响应");
            break;
          case 504:
            this.wxhb=res.data.money
            alert(res.data.msg);
            break;
          default:
        }
      loading.close();
        this.abledToClick=false;

      }).catch(e=>{
        console.log(e);
      })
    },
    convert(data){
      switch (data) {
          case '1':
          data="A";
          break;
          case '2':
          data="B";
          break;
          case '3':
          data="C";
          break;
          case '4':
          data="D";
          break;
          case '5':
          data="E";
          break;
      }
      return data;
    },
    counterStart(){
      let that=this;
        this.timer=setInterval(()=>{
        if(that.totalTimesLeft>0){
            that.totalTimesLeft--;
        }else{
          that.totalTimesLeft="时间到!";
          //时间到 未答的题不作处理!
          this.syncDates();

        }

      },1000)
    },
    sub(index){
            let that=this;
            if(this.questions.length===index+1){
                  //最后一道题
                  if (confirm("确认提交吗?")) {
                    let dot="";
                    let userAnser=new Array();
                    //count per question's answer
                    this.syncDates();
                    }
              }
            else{
              let  ops=document.querySelectorAll(`#block${index} input:checked`);
              if (ops.length==0) {
                alert("请选择!");
                return false;
              }
              this.chooseQes("next",index);
            }
      },
  },
  beforeDestroy: function () {
    clearInterval(this.timer)
  },
  props:['msg'],
  mounted(){
      sessionStorage.getItem("openid")?null:this.$router.push("/front/index");
    Array.prototype.shunt=function(){
      //随机洗牌算法
    	let __this=this;
    	for(let i=0;i<__this.length;i++){
    			let seeds=Math.floor(Math.random()*(__this.length-i));
    			let temp=__this[__this.length-i-1];
    			[__this[__this.length-i-1],__this[seeds]]=[__this[seeds],temp]
    	}
    	return __this;
    }
    this.config=JSON.parse(sessionStorage.getItem("syssetting"));
    this.$axios.post(this.url,{
      action:"getQuestions",
      tag:this.msg
        }).then(res=>{
          res.data.map((v,k)=>{
            this.qid.push(v.id);
            let datas=v.answer.split("###");
            datas.shift();
            res.data[k].correctIndex="";
            datas.map((v,k)=>{
              datas[k]=v.split(".")
            });
              datas.shunt();
            res.data[k]['answer']=datas;

              res.data[k].clickAble=false;
              if(/,/.test(v.correctType)){
                res.data[k]['type']="checkbox"
              }else{
                res.data[k]['type']="radio"
              }
              //映射正确答案
              let _qRight=res.data[k].correctType.split(",").sort();
              res.data[k].correctType=_qRight;

              _qRight.map(v=>{
                datas.map((v1,k1)=>{
                  if (v1[0]==v) {
                    //当前选项为正确答案，将key转化为ABC,并存储到当前list中
                    let _ar="A";
                    switch (k1) {
                          case 0:
                          _ar="A";
                          break;
                          case 1:
                          _ar="B";
                          break;
                          case 2:
                          _ar="C";
                          break;
                          case 3:
                          _ar="D";
                          break;
                      default:
                    }
                    res.data[k].correctIndex+=_ar;
                  }
                })
              })
            //  res.data[k].correctType=
          })
        this.questions=res.data;
        this.totalTimesLeft=Number(this.config.perconunter)*res.data.length;
        this.counterStart();
    }).catch(e=>{
      console.log(e)
    })

  }
}
</script>
<style media="screen" scoped>
.content {
	background: rgba(255, 255, 255, 0.6);
	border-radius: 6px;
	width: 560px;
	margin: 0 auto;
	padding: 20px;
	margin-top: 30px;
	line-height: 36px;
	min-height: 280px;
	color: #450b0c;
	font-size: 30px;
}
.el-button--medium{
    padding: 12px 22px;
        font-size: 24px;
    margin: 9px;
}
.countdown{
  color: red;
  position: absolute;
  top: 139px;
  right: 31px;
  font-size: 44px;
}
li{
  list-style: none;
}
.el-message-box{
  width: 80% !important;

}
.el-message-box__content{
  font-size: 30px !important;
}
.el-message-box__btns button{
  font-size: 25px !important;
}
  #a1{
    font-size: 68px;
    color: red;
    font-weight: bold;
    text-indent: 77px;
  }
  .ico1{
    font-size: 194px;
    position: absolute;
    top: 50%;
    left: 50%;
    /* margin: auto; */
    margin-left: -92px;
    margin-top: -119px;
    color: green;
    opacity: 0.7;
  }
  .ico2{
    font-size: 194px;
    position: absolute;
    top: 50%;
    left: 50%;
    /* margin: auto; */
    margin-left: -92px;
    margin-top: -119px;
    color: red;
    opacity: 0.7;
  }
  .finaly{
    color: red;
    text-align: center;
    margin: 10px;

  }
  .el-loading-mask.is-fullscreen {
    font-size: 85px;
  }
  .el-loading-text{
    font-size: 23px;
  }
  .count{
    text-indent: 3%;
    font-size: 29px;
    color: orangered;
    position: absolute;
    top: 139px;
    min-width: 178px;
  }
</style>
