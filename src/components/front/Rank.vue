<template >
  <section id="ranking">
     <span id="ranking_title">
       <el-select v-model="select_cate" placeholder="筛选时间段" class="handle-select mr10">
           <el-option key="1" label="本周" value="week"></el-option>
           <el-option key="2" label="本月" value="month"></el-option>
           <el-option key="3" label="本季度" value="quarter"></el-option>
           <el-option key="4" label="最近一年" value="year"></el-option>
           <el-option key="5" label="历史总排名" value="total" ></el-option>
       </el-select>

     </span>
     <el-select v-show="roleFilter" v-model="select_role" placeholder="筛选人员分类" class="handle-select m2">
         <el-option key="1" label="内部" value="inner"></el-option>
         <el-option key="2" label="外部" value="outter"></el-option>
         <el-option key="3" label="所有" value="all"></el-option>
     </el-select>
    <section id="ranking_list">
      <section class="box" v-for="(value,index) in datas">
        <section :title="index+1" class="col_1">{{index+1}}</section>
        <section class="col_2"><img :src="value.headImg"></section>
        <section class="col_3">{{value.dirName}}</section>
        <section class="col_4">{{value.level}}</section>
        <section class="col_4">{{value.scores}}</section>
      </section>

    </section>
      <router-link to="index" id="play_game">返回答题</router-link>
 </section>
</template>
<script type="text/javascript">
    let myWorker=new Worker("../static/js/webworker/FrontWorker.js");
import Wx from './WeixinJssdk';
  export default {
    data(){
      return{
        url: 'api/user.php',
        //url: 'https://www.easy-mock.com/mock/5b3c79dafd1ca96a4ed24884/scores/scores',
        datas:[],
        role:JSON.parse(localStorage.getItem("wxUser-jw")).__Uinfos.role,
        select_role:"all",
        select_cate:"total",
        sourceData:[]
      }
    },
    computed:{
      roleFilter(){
            if (this.role) {
              return true
            }else{
              return false;
            }
      }
    },
    watch:{
      select_role(val){
        let readyDatas={...this.$store.state.scoresInfo};

        if (val=="all") {
            this.sourceData=readyDatas;
        }else{
            readyDatas.userInfo=  readyDatas.userInfo.filter(v=>{
                if (val=="inner") {
                  return  v.role==1
                }else{
                  return v.role==0
                }
            })
            this.sourceData=readyDatas;
        }

          this.filterDatas(this.select_cate)
      },
      select_cate(val){
        this.filterDatas(val);
      }
    },
    methods:{
      filterDatas(val){
        if (val=="total") {
          myWorker.postMessage({
            action:val,
            data:this.sourceData
          })
        }else{
          myWorker.postMessage({
            action:"sortDiff",
            type:val,
            data:this.sourceData
          })
        }
      },
      toMain(tag){
        this.$router.push({ name: 'main', params: { userId: tag }})
      },
      dealDates(d){

          switch (d.responseType) {
            case "total":
                this.datas =d.data.splice(0,50);
              break;
            default:

          }
      },
       getData() {
            this.$axios.post(this.url, {
                action:"scoresgetUsers",

            }).then(res=> {
              let tempData=res.data;
                if (this.role==0) {
                  tempData.userInfo=res.data.userInfo.filter(v=>{
                    return v.role==0
                  })
                }
              this.$store.commit("setScores",tempData);
              //存到vuex中
                this.sourceData=tempData;
              myWorker.postMessage({action:"total",data:tempData,role:this.role});
              myWorker.onmessage=(e)=>{
                this.dealDates(e.data)
              }
            }).catch(e=>{
              console.log(e);
              this.$message.error("网络传输错误!");
            })
        }
    },
    mounted(){
    this.getData();
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
<style scope>
#rank{
  display: block;
width: 93%;
height: 70%;
position: absolute;
left: 1%;
top: 10%;
border: 2px #e7383d solid;
background-color: #fff;
border-radius: 20px;
padding: 30px 15px;
}
.mr10 input{
  font-size: 27px;
}
.el-input--small .el-input__inner{
  height: 62px;
line-height: 62px;
}
.el-select-dropdown__item{
  font-size: 23px;
}
.el-input--small{
  font-size: 20px;
}
.col_3{
  overflow: hidden;
      -o-text-overflow: ellipsis;
      text-overflow: ellipsis;
      white-space: nowrap;


}

.m2{
  position: absolute;
  position: absolute;
right: 0;
width: 24%;
top: -23px;
}
</style>
