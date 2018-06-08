<template>
    <div class="table">
        <div class="crumbs">
            <el-breadcrumb separator="/">
                <el-breadcrumb-item><i class="el-icon-tickets"></i> 用户</el-breadcrumb-item>
            </el-breadcrumb>
        </div>
        <div class="container">
            <div class="handle-box">
                <el-button type="primary" icon="delete" class="handle-del mr10" @click="passAll">批量审核</el-button>
                <el-select v-model="select_cate" placeholder="筛选类型" class="handle-select mr10">
                    <el-option key="1" label="达到分数线" value="1"></el-option>
                    <el-option key="2" label="未达到分数线" value="0"></el-option>
                </el-select>
                <el-input v-model="select_word" placeholder="筛选微信昵称关键词" class="handle-input mr10"></el-input>
                <el-button type="primary" icon="search" @click="search">搜索</el-button>
            </div>

            <el-table  max-height="650" :data="data" border style="width: 100%" ref="multipleTable" :row-class-name="tableRowClassname" @selection-change="handleSelectionChange">
              <el-table-column type="selection" width="55"></el-table-column>
                <!-- <el-table-column prop="id" width="55" label="id"></el-table-column> -->
                <el-table-column prop="id" width="60" label="id"></el-table-column>
                <el-table-column prop="nickname" label="微信昵称" width="120">
                </el-table-column>
                <el-table-column prop="result" label="是否达到指定分数线" >
                </el-table-column>

                <el-table-column prop="city" label="城市" >
                </el-table-column>

                <el-table-column prop="RegistTime" label="激活时间" >
                </el-table-column>
                <el-table-column prop="scores" label="得分" >
                </el-table-column>
                <el-table-column prop="money" label="获得的红包" >
                </el-table-column>

                <el-table-column
                  label="红包发放详情"
                  width="180">
                  <template slot-scope="scope">
                    <div class="">
                        {{scope.row.resData.err_code_des}}
                    </div>

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
            this.tableData=this.backUpData.filter(v=>v.result==val)
          }
        },
        created() {
            this.getData();
        },
        computed: {
            data() {
                  return this.tableData.slice((this.cur_page-1)*10,this.cur_page*10)
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
                    res.data.map((v,k)=>{
                        res.data[k]['resData']=JSON.parse(v['resData']);
                    });
                    this.backUpData = res.data;
                    this.tableData = res.data;

                }).catch(e=>{
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
            passAll() {
                const length = this.multipleSelection.length;
                if (length==0) {
                  this.$message.warning("所选项无效!");
                  return false;
                }
                let __this=this;
                let str = '';
                this.pass_list = this.pass_list.concat(this.multipleSelection);
                this.$axios.post(this.url,{
                  action:"update",
                  id:this.pass_list
                }).then(res=>{
                  if(res.data!=1){
                    this.$message.error(`更新失败!`);
                    return false;
                  }
                  __this.pass_list.map((v)=>{
                    __this.tableData.map((value,key)=>{

                      if(value.id==v){
                        __this.tableData[key].status=1
                      }
                    })
                    __this.backUpData.map((_value,_key)=>{
                      if(_value.id==v){
                        __this.backUpData[_key].status=1
                      }
                    })

                  })
                    this.$message.success(`更新成功!`);
                }).catch(e=>{
                  console.log(res)
              })
                this.multipleSelection = [];
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
