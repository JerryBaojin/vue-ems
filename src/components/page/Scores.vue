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
                    <el-option key="1" label="当前月份" value="1"></el-option>
                    <el-option :key="k" :label="v" :value="v" v-for="(v,k) in selectOptions"></el-option>
                </el-select>
                <el-input v-model="select_word" placeholder="筛选微信昵称关键词" class="handle-input mr10"></el-input>
                <el-button type="primary" icon="search" @click="search">搜索</el-button>
            </div>

            <el-table  max-height="650" :data="data" border style="width: 100%" ref="multipleTable" :row-class-name="tableRowClassname" @selection-change="handleSelectionChange">
              <el-table-column type="selection" width="55"></el-table-column>
                <!-- <el-table-column prop="id" width="55" label="id"></el-table-column> -->
                <el-table-column prop="UID" width="60" label="登录ID"></el-table-column>
                <el-table-column prop="nickname" label="微信昵称" width="120">
                </el-table-column>
                <el-table-column prop="name" label="真实姓名" >
                </el-table-column>
                <el-table-column prop="tag" label="当前时间段" >
                </el-table-column>
                <el-table-column prop="nowDates" label="积分">

                </el-table-column>

                <el-table-column  label="排行" >
                  <template slot-scope="scope">
                      第{{scope.row.rank}}名
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
    export default {
        data() {
            return {
                url: 'api/user.php',
                tableData: [],
                backUpData: [],
                uploadedFiles:[],
                selectOptions:[],
                cur_page: 1,
                multipleSelection: [],
                select_cate: '',
                select_word: '',
                pass_list: [],
                dialogVisible: false,
                delVisible:false,
                visible2:false,
                is_search: false,
                idx: -1
            }
        },
        watch:{
          select_cate(val){
              /*
              this.tableData=this.backUpData.filter(v=>{
                if(val==0){
                  return    v.oid==null;
                }else{
                  return  v.oid!=null;
                }
              }
            )  */
          }
        },
        created() {
            this.getData();
        },
        computed: {
            data() {
                  let that=this;
                  var p=[...that.tableData.slice((this.cur_page-1)*10,this.cur_page*10)];
                  p.map((v,k)=>{
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
                  return p;
            }
        },
        methods: {
            handleCurrentChange(val) {
                this.cur_page = val;
            },
            tableRowClassname({row,rowIndex}){
              if (row.RegistTime != null) {
                 return '';
               } else{
                 return 'warning-row';
               }
            },
            getData() {
                this.$axios.post(this.url, {
                    action:"getUsers",
                }).then(res=> {
                  let tempArray=[];
                    res.data.map(v=>{
                      if(v.monthCount.length>=1){
                        v.monthCount.map(value=>{
                            tempArray.push(value.month)
                        })
                      }
                    })
                    this.selectOptions=Array.from(new Set(tempArray));
                    this.backUpData = res.data;
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
