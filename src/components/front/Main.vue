<template >
  <div id="answer" class="w640">
  			<header>
  				<div class="hm_icon">
  					<span class="f-l">
              <router-link to="person">
    						<img :src="uInfo.headImg" style="" />
    						<h2>{{uInfo.nickname}}<br>
                  <!-- <small>积分：2050</small> -->
                </h2>
              </router-link>
  					</span>
  					<span class="f-r">
              <router-link to="Rank"><img src="../../../static/img/ranking.png" alt=""></router-link>
  					</span>
  				</div>
  				<div class="title">
  					<h1>每日一题，学习教育</h1>
  				</div>
          <div class="btns" v-if="editAble">
             <el-button size="medium" type="primary" @click="handClick('before')" :disabled="index==0" icon="el-icon-arrow-left">上一题</el-button>
             <el-button size="medium"  @click="handClick('next')" :disabled="index==-1" type="primary">下一题<i class="el-icon-arrow-right el-icon--right"></i></el-button>
         </div>
  			</header>

        <component :is="currentView" :msg="type"  ref="child" v-on:disableEdit="hideStep" v-on:currentNow="nowTag" keep-alive></component>
  </div>
</template>
<script type="text/javascript">
import Wx from './WeixinJssdk';
import vQuestions from './QuestionS';
  export default {
    data(){
      return{
          uInfo:{
              headImg:"",
              nickname:""
          },
          currentView:"vQuestions",
              index:0,
              editAble:true
      }
    },
    methods:{
             hideStep(type){
               this.editAble=type;
             },
             handClick(action){
               this.$refs.child.chooseQes(action);
             },
             nowTag(id){
               this.index=id;
             }
       },
    components:{
      vQuestions
    },
    computed:{
      type(){
        return this.$route.params.type
      }
    },
    mounted(){
      if(this.$route.params.hasOwnProperty("type")){
            this.uInfo=JSON.parse(localStorage.getItem("wxUser-jw"))['__Uinfos'];
      }else{
        this.$router.push("/front/index");
      }

      /*
      let dates={
      "title":"甜城味·内江美食地图",
      "desc":"内江史上最全的美食地图,没有之一!",
      "image":"http://weixin.scnjnews.com/foods/share.png",
      "link":"http://weixin.scnjnews.com/foods/#/",
    }
      Wx(dates);
      */
    }
  }
</script>
<style media="screen" scoped>
  .btns{
    margin:31px;
    display: flex;
flex-direction: row;
flex-wrap: nowrap;
justify-content: space-between;
  }
  .el-button--medium {
    font-size: 25px;
  }
  .f-l h2 {
        margin: 35px 0 0 20px;
  }
</style>
