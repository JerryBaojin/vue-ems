<template id="">
  <div class="">
      <div class="count">当前进度{{current+1}}/{{questions.length}}</div>
              <div v-for="(value,index) in questions" v-show="index==current" :id="'block'+index">
                <div id="q1">
                  <div class="content">
                    <p class="subject_t">{{index+1}}、{{value.question}}。</p>
                    <p v-for="(items,key) in value.answer">
                      <span><input :id="'rd'+value.id+key" :name="'rd'+index" :data-pid="key+1" :type="value.type" ></span>
                      <label :for="'rd'+value.id+key">{{items}}</label>
                    </p>
                  <div class="enter_btn">
                    <a id="b1" @click="sub(index)" href="javascript:void(0);">确定</a>
                  </div>
                </div>
                <div id="a1" v-show="checkResult.toggle">
                  <p>正确答案:{{value.correct}}</p>
                </div>
                  </div>
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
        checkResult:{
          isNow:false,
          result:false,
          toggle:false
        },
        correctA:[]
    }
  },
  methods:{
    sub(index){
    let that=this;
    let  ops=document.querySelectorAll("#block0 input:checked");
    let __nowAnswers=[];
    for(let k=0;k<ops.length;k++){
      __nowAnswers.push(ops[k].dataset.pid)
    }
    console.log(__nowAnswers.join(""),this.questions[index]['correctType'])
    
    if(__nowAnswers.join("")==this.questions[index]['correctType']){
      this.checkResult={...this.checkResult,isNow:true,result:true};
      this.correctA.push(this.questions[index].id);
      setTimeout(()=>{
        that.checkResult={
          isNow:false,
          result:false,
          toggle:false
        }
        that.current+=1;
      },1500)
    }else{
        this.checkResult={...this.checkResult,isNow:true,result:false,toggle:true};
    }

    /*this.questions[index].correctType.map((v,k)=>{
      for(let k=0;k<ops.length;k++){
        ops[k].dataset.pid
      }
    })
    */
        if(this.questions[index].type=="radio"){

          ops[0].dataset.pid==this.questions[index].correctType[0]

        }
      console.log(index);
    }
  },
  props:['msg'],
  mounted(){
    this.$axios.post(this.url,{
      action:"getQuestions"
    }).then(res=>{
      res.data.map((v,k)=>{
        res.data[k]['answer']=v.answer.split("###");
          if(/,/.test(v.correctType)){
            // res.data[k]['correctType']=v.correctType.split(",")
            res.data[k]['type']="checkbox"
          }else{
            // res.data[k]['correctType']=[v.correctType];
              res.data[k]['type']="radio"
          }
      })
        this.questions=res.data;
    }).catch(e=>{
      console.log(e)
    })
  }
}
</script>
<style media="screen">
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
    text-indent: 4%;
    font-size: 26px;
    color: orangered;
    position: absolute;
    top: 139px;
  }
</style>
