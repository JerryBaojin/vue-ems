<template>
    <div class="table">
        <div class="crumbs">
            <el-breadcrumb separator="/">
                <el-breadcrumb-item><i class="el-icon-tickets"></i> 用户积分</el-breadcrumb-item>
            </el-breadcrumb>
        </div>
        <div class="container">
            <div class="handle-box">
                <el-button type="primary" icon="delete" class="handle-del mr10" @click="exportExcel">导出当前格式的数据</el-button>
                <el-select v-model="select_cate" placeholder="筛选时间段" class="handle-select mr10">
                    <el-option key="1" label="本周" value="week"></el-option>
                    <el-option key="2" label="本月" value="month"></el-option>
                    <el-option key="3" label="本季度" value="quarter"></el-option>
                    <el-option key="4" label="最近一年" value="year"></el-option>
                    <el-option key="5" label="历史总排名" value="total" ></el-option>
                </el-select>

                <el-select v-model="select_people" placeholder="筛选内/外部人员" class="handle-select mr10">
                    <el-option key="2" label="默认" value="defaultPeople"></el-option>
                    <el-option key="1" label="内部人员" value="inner"></el-option>
                    <el-option key="3" label="外部人员" value="outter"></el-option>
                </el-select>

                <el-input v-model="select_word" placeholder="筛选微信昵称关键词" class="handle-input mr10"></el-input>
                <el-button type="primary" icon="search" @click="search">搜索</el-button>
            </div>

            <el-table     v-loading="loading2" filterable  @sort-change="handleSort"  max-height="650" :data="data" border style="width: 100%" ref="multipleTable" :row-class-name="tableRowClassname" @selection-change="handleSelectionChange">
              <el-table-column type="selection" width="55"></el-table-column>
                <!-- <el-table-column prop="id" width="55" label="id"></el-table-column> -->
                <el-table-column prop="UID" width="60" label="标记ID"></el-table-column>
                <el-table-column prop="nickname" label="微信昵称" width="120">
                </el-table-column>
                <el-table-column prop="dirName" label="系统内昵称" width="120">
                </el-table-column>
                <el-table-column prop="name" label="真实姓名" >
                </el-table-column>

                <el-table-column prop="scores" sortable label="积分">

                </el-table-column>
                <el-table-column    prop="workUnit" label="所属区域或单位">

                </el-table-column>
                <el-table-column :filter-method="filterRole" prop="role" :filters="[{text:'内部人员',value:'1'},{text:'外部人员',value:'0'}]"   label="人员分类" >
                  <template slot-scope="scope">
                    {{scope.row.role=="1"?'内部人员':"外部人员"}}
                  </template>
                </el-table-column>
                <el-table-column  label="排行" >
                  <template slot-scope="scope">
                      第{{ (scope.row.rank)}}名
                  </template>
                </el-table-column>


                <el-table-column v-if="false" label="操作" width="180">
                    <template slot-scope="scope">
                        <el-button size="small" type="success" :disabled="scope.row.status==1" @click="handlePass(scope)">删除</el-button>
                    </template>
                </el-table-column>
            </el-table>

            <div class="pagination">
                <el-pagination @current-change="handleCurrentChange" layout="prev, pager, next" :total="tableData.length">
                </el-pagination>
            </div>
        </div>
    </div>
</template>

<script>
          let myWorker=new Worker("../static/js/webworker/webWorker.js");

    export default {
        data() {
            return {


              //  url: 'api/user.php',
                url: 'https://www.easy-mock.com/mock/5b3c79dafd1ca96a4ed24884/scores/scores',
                tableData: [],
                backUpData: [],
                uploadedFiles:[],
                selectOptions:[],
                cur_page: 1,
                multipleSelection: [],
                select_cate: 'total',
                select_people:"defaultPeople",
                select_word: '',
                pass_list: [],
                dialogVisible: false,
                delVisible:false,
                visible2:false,
                is_search: false,
                idx: -1,
                  loading2: true
            }
        },
        watch:{
          select_cate(val){
              myWorker.postMessage({action:val})
          },
          select_people(val){
              myWorker.postMessage({action:val})
          }

        },
        created() {
            this.getData();
        },
        computed: {
            data() {
                  let that=this;
                  var p=[...that.tableData.slice((this.cur_page-1)*10,this.cur_page*10)];

                /*  p.map((v,k)=>{
                      p[k].rank=k+1;
                    if(that.select_cate==1 || that.select_cate==''){
                      p[k]['nowDates']=v.scores;
                      p[k]['tag']="当前月";
                    }else{
                      v.monthCount.map(value=> {
                        if(value.month==that.select_cate){
                            p[k]['nowDates']=value.scoress;
                            console.log(value)
                        }
                      })
                      p[k]['tag']=that.select_cate;

                    }
                  })
                  */
                  return p;
            }
        },
        methods: {
          filterRole(value,row){
            return row.role==value;


          },
          handleSort(d){
            if (d.order=='descending') {
                myWorker.postMessage({action:"total"})
            }else{
                myWorker.postMessage({action:"asc"})
            }

          },
            dealDates(d){
                switch (d.responseType) {
                  case "total":

                      this.tableData =d.data;
                    break;
                  default:

                }
                this.loading2=false;
            },
            handleCurrentChange(val) {
                this.cur_page = val;
            },
            tableRowClassname({row,rowIndex}){
              let x=[...row];
              for (var i = 0; i < x.length; i++) {
                array[i]
              }
              if (row.role==0) {
                 return '';
               } else{
                 return 'warning-row';
               }
            },
            getData() {
                this.$axios.post(this.url, {
                    action:"scoresgetUsers",
                }).then(res=> {
              //    this.$store.commit("setScores",res.data);
                  //存到vuex中
                  myWorker.postMessage({action:"total",data:res.data});
                  myWorker.onmessage=(e)=>{
                    this.dealDates(e.data)
                  }
                    this.backUpData = res.data[0];//原始数据
                  return false;
                  let tempArray=[];
                    res.data.map(v=>{
                      if(v.monthCount.length>=1){
                        v.monthCount.map(value=>{
                            tempArray.push(value.month)
                        })
                      }
                    })
                    this.selectOptions=Array.from(new Set(tempArray));

                    this.tableData = res.data;

                }).catch(e=>{
                  console.log(e);
                  this.$message.error("网络传输错误!");
                })
            },
            search() {
                this.is_search = true;
                let reg=new RegExp(this.select_word)
              this.tableData=this.backUpData.filter(v=> reg.test(v.nickname))
            },
            filterTag(value, row) {
                return row.tag === value;
            },
            exportExcel() {

            window.location.href="api/__excel.php?type="+this.select_cate;
            },
            handlePass(scope) {
                this.$axios.post(this.url,{
                  action:"update",
                  id:new Array(scope.row.id)
                }).then(res=>{
                  if(res.data!=1){
                    this.$message.error(`更新失败!`);
                    return false;
                  }
                  scope.row.status=1;

                  this.$set(this.tableData,scope.$index,scope.row)
                  this.backUpData.map((v,k)=>{
                    if(v.id==scope.row.id){
                           this.$set(this.tableData,k,scope.row)
                    }
                  })

                    this.$message.success(`更新成功!`);
                }).catch(e=>{
                  console.log(res)
              })
            },
            handleSelectionChange(val) {
                this.multipleSelection = val.filter(v=>{ if (v.status==0) {return v.id;}}).map(v=>{return v.id});
            }

        }
    }

</script>

<style >

.el-table .warning-row {
  background: oldlace;
}

.el-table .success-row {
  background: #f0f9eb;
}

  .el-upload {
    width: unset !important;
    height:unset !important;
  }
  .upload-demo{
    width: 360px;
  }
    .handle-box {
        margin-bottom: 20px;
    }
    .items{
      display:flex;margin:5px 0 5px;
    }
    .items span{
      margin-left:5px;
    }
    .options label{
      display: block;
      margin: 5px 0 5px !important;
    }
    .handle-select {
        width: 120px;
    }

    .handle-input {
        width: 300px;
        display: inline-block;
    }
    .del-dialog-cnt{
        font-size: 16px;
        text-align: center
    }
</style>
