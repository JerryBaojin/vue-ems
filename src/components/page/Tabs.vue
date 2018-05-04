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
                    <el-option key="1" label="已审核" value="1"></el-option>
                    <el-option key="2" label="未审核" value="0"></el-option>
                </el-select>
                <el-input v-model="select_word" placeholder="筛选微信昵称关键词" class="handle-input mr10"></el-input>
                <el-button type="primary" icon="search" @click="search">搜索</el-button>
            </div>

            <el-table :data="data" border style="width: 100%" ref="multipleTable" @selection-change="handleSelectionChange">
              <el-table-column type="selection" width="55"></el-table-column>
                <el-table-column prop="id" width="55" label="id"></el-table-column>
                <el-table-column prop="nickname" label="微信昵称" width="120">
                </el-table-column>
                <el-table-column prop="phone" label="手机号" >
                </el-table-column>
                <el-table-column prop="idCard" label="身份证号" >
                </el-table-column>
                <el-table-column prop="RegistTime" label="注册时间" >
                </el-table-column>
                <el-table-column  label="状态" >
                  <template slot-scope="scope">
                  <div class="">
                    {{scope.row.status==0?'未审核':'已审核'}}
                  </div>
                  </template>
                </el-table-column>
                <el-table-column label="操作" width="180">
                    <template slot-scope="scope">
                        <el-button size="small" type="success" :disabled="scope.row.status==1" @click="handlePass(scope)">审核</el-button>
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
            console.log(this.backUpData)
            this.tableData=this.backUpData.filter(v=>v.status==val)
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
            getData() {
                this.$axios.post(this.url, {
                    action:"getQuestions",
                    page: this.cur_page
                }).then((res) => {
                    this.backUpData = res.data;
                    this.tableData = res.data;
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
