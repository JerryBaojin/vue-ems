<template id="">
  <div class="">
      <div class="count">进度{{current+1}}/{{questions.length}}</div>
            <ul class="countdown">
              <li> <span class="seconds">{{totalTimesLeft}}</span></li>
            </ul>
            <div  v-if="!isLast">
              <div v-for="(value,index) in questions" v-show="index==current" :id="'block'+index">
                <div id="q1">
                  <div class="content">
                    <p class="subject_t">{{index+1}}、{{value.question}}。</p>
                    <p v-for="(items,key) in value.answer">
                      <span><input :id="'rd'+value.id+key" :disabled="value.clickAble"  :name="'rd'+index" :data-answer="items[0]" :data-pid="key+1" :type="value.type" ></span>
                      <label :for="'rd'+value.id+key" >{{items[1]}}</label>
                    </p>
                  <div class="enter_btn">
                    <a id="b1" @click="sub(index)" v-if="doneGrade.length==0" disabled="true" href="javascript:void(0);">确定</a>
                  </div>
                </div>
                <div id="a1" v-show="checkResult.toggle">
                  <p>正确答案:{{value.correct}}</p>
                </div>
                  </div>
              </div>
            </div>
            <div v-if="isLast" class="content">

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
        isLast:false,
        abledToClick:true,
        timer:null,
        correctA:[],
        doneGrade:[],
        totalTimesLeft:0
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
    checkQuestion(i){
      let result=false;
      this.current=i;
      this.doneGrade[i].res==0?result=false:result=true;
      this.checkResult={
        isNow:false,
        result,
        toggle:false
      }

      //回答正确时
      //  this.checkResult={...this.checkResult,isNow:true,result:true};

                        /*
                          this.questions[index].clickAble=true;
                          this.questions[index]['correctType'].length>=2?dot=",":dot="";
                          if(__nowAnswers.join(dot)==this.questions[index]['correctType']){
                            this.checkResult={...this.checkResult,isNow:true,result:true};
                            this.correctA.push(this.questions[index].id);
                          }else{
                              this.checkResult={...this.checkResult,isNow:true,result:false,toggle:true};
                          }

                                if(this.current+1<this.questions.length){
                                  setTimeout(()=>{
                                    that.checkResult={
                                      isNow:false,
                                      result:false,
                                      toggle:false
                                    }
                                    that.current+=1;
                                  },1500)
                                }else{
                                  this.syncDates();
                                }*/
        this.$emit('currentNow',i+1);//upup
        this.$emit("disableEdit",true);
    },
    chooseQes(action,index){
      index=index||this.current;
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
    },
    syncDates(){
      const infos=Array.from(this.correctA);
      let that=this;
      let str="";
      let __scores=infos.length*2+(this.questions.length-infos.length)*1;
      infos.length>0?str=`恭喜你答对${infos.length}道题,获得${__scores}积分!`:str=`很遗憾你没有回答正确的题,获得${__scores}积分!`;
      this.msg!="muti"?str+="请明天再来!":'';
      this.$alert(str,  {
        confirmButtonText: '确定',
        callback: action => {

        }
      });
      this.$axios.post(this.url,{
        action:"saveQinfos",
        uid:localStorage.getItem("token"),
        scores:__scores,
        Qid:this.qid,
        type:this.msg
      }).then(res=>{
        clearInterval(that.timer)
        that.abledToClick=false;

        if(res.data==0){
          alert("与服务器失去连接，请重新答题!");
        }
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
          if(this.msg=="single"){
              //直接提交
              this.syncDates();
              this.checkResult={...this.checkResult,isNow:true,result:false,toggle:true};
          }else{
            //多选
            that.correctA=[];
            for (let i = 0; i <= that.current; i++) {
                let dot="";
                let  ops=document.querySelectorAll(`#block${i} input:checked`);
                let __nowAnswers=[];
                for(let k=0;k<ops.length;k++){
                  __nowAnswers.push(ops[k].dataset.pid)
                }
                that.questions[i]['correctType'].length>=2?dot=",":dot="";
                if(__nowAnswers.join(dot)==that.questions[i]['correctType']){
                  that.correctA.push(that.questions[i].id);
                }
            }
            this.syncDates();
          }

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
                            clearInterval(this.timer)
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
              res.data[k].correctType=res.data[k].correctType.split(",").sort();
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
<style media="screen">
.el-button--medium{
    padding: 12px 22px;
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
  .count{
    text-indent: 3%;
    font-size: 29px;
    color: orangered;
    position: absolute;
    top: 139px;
    min-width: 178px;
  }
</style>
