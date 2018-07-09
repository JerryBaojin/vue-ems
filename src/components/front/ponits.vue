<template >
  <div class="mall_main">
		<div id="child_header">
		    <div class="goback"><a href="javascript:history.back(-1)"><i></i></a></div>
		    <div class="current_location"><span>我的积分</span></div>
		</div>

		<div class="my_points">
		    <p v-for="items in infos">
		        <span>{{items.type}}</span><em>+{{items.result}}</em>
		        <span class="sp_1"><a href=""></a></span><time>{{items.times}}</time>
		    </p>
        <p v-if="hasMore" style="color:black;text-align: center;" @click="loadMore">
		       点击加载更多
		    </p>

		</div>
</div>
</template>

<script type="text/javascript">
export default {
  data(){
    return{
        hasMore:false,
        infos:[],
        index:0
    }
  },
  methods:{
    loadMore(){
      if(this.hasMore){
        this.index+=10;
      }
      this.getDatas();
    },
    formatDate(t){

    let  now=new Date(t*1000);
  　　var year = now.getFullYear(),
  　　month = now.getMonth() + 1,
  　　date = now.getDate(),
  　　hour = now.getHours(),
  　　minute = now.getMinutes(),
  　　second = now.getSeconds();
  　　return year + "-" + month + "-" + date + " " + hour + ":" + minute + ":" + second;
    },
    getDatas(){
      this.$axios.post("api/frontUser.php",{
        action:"viewScores",
        uid:JSON.parse(localStorage.getItem('wxUser-jw')).__Uinfos
.uid,
        index:this.index
      }).then(res=>{
        res.data.map((v,k)=>{
//          1531098809
res.data[k]['times']=this.formatDate(v.times);
          switch (v.type) {
            case "single":
                res.data[k]['type']="每日一题";
              break;
            case "muti":
              res.data[k]['type']="每周一题";
              break;
              case "taoti":
                res.data[k]['type']="套题测试";
                break;
            default:

          }
        })
        res.data.length==10?this.hasMore=true:this.hasMore=false;
        this.infos=this.infos.concat(res.data);
      }).catch(e=>{
        console.log(e);
      })
    }
  },
  mounted(){
    this.getDatas();
  }
}
</script>
<style media="screen">
.my_points{
  height: 800px;
  overflow: scroll;
}
</style>
