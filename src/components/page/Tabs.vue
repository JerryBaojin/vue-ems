<template>
    <div class="table">
        <div class="crumbs">
            <el-breadcrumb separator="/">
                <el-breadcrumb-item><i class="el-icon-tickets"></i> 用户</el-breadcrumb-item>
            </el-breadcrumb>
        </div>
        <div class="container">
            <div class="handle-box">
                <el-button type="primary" icon="delete" class="handle-del mr10" @click="DeleteAll">批量删除</el-button>
                <el-select v-model="select_cate" placeholder="筛选用户" class="handle-select mr10">
                    <el-option key="1" label="外部用户" value="1"></el-option>
                    <el-option key="2" label="内部用户" value="0"></el-option>
                </el-select>
                <el-input v-model="select_word" placeholder="筛选微信昵称关键词" class="handle-input mr10"></el-input>
                <el-button type="primary" icon="search" @click="search">搜索</el-button>
                <el-button type="primary" @click="dialogVisible = true">点击上传内部用户</el-button>

                <el-dialog
                  title="提示"
                  :visible.sync="dialogVisible"
                  width="30%"
                >
                  <span>
                    <el-upload
                      class="upload-demo"
                      :action="url"
                      :on-success="handleUploadSuccess"
                      accept=".csv"
                      :limit="1"
                      :file-list="uploadedFiles"
                      >
                      <el-button size="small" type="primary" >点击上传</el-button>
                      <div slot="tip" class="el-upload__tip">只能上传csv文件，且不超过20m</div>
                      </el-upload>
                  </span>
                  <span slot="footer" class="dialog-footer">
                    <el-button @click="dialogVisible = false">取 消</el-button>
                    <el-button type="primary" @click="dialogVisible = false">确 定</el-button>
                  </span>
                </el-dialog>

            </div>

            <el-table  max-height="650" :data="data" border style="width: 100%" ref="multipleTable" :row-class-name="tableRowClassname" @selection-change="handleSelectionChange">
              <el-table-column type="selection" width="55"></el-table-column>
                <!-- <el-table-column prop="id" width="55" label="id"></el-table-column> -->
                <el-table-column prop="UID" width="60" label="登录ID"></el-table-column>
                <el-table-column prop="nickname" label="微信昵称" width="120">
                </el-table-column>
                <el-table-column prop="name" label="真实姓名" >
                </el-table-column>

                <el-table-column prop="workUnit" label="所在区域" >
                </el-table-column>
                <el-table-column prop="scores" sortable label="积分" >
                </el-table-column>
                <!-- <el-table-column
                  label="历史得分"
                  width="180">
                  <template slot-scope="scope">
                    <el-popover trigger="hover" placement="top" v-if="scope.row.monthCount.length>0">
                      <div v-for="(item,index) in scope.row.monthCount" >
                        <p>月份：{{item.month}},得分:{{item.scoress}},排名:第{{item.rank}}名</p>
                      </div>
                      <div slot="reference" class="name-wrapper">
                        <el-tag size="medium">历史得分</el-tag>
                      </div>
                    </el-popover>
                  </template>
                </el-table-column> -->
                <el-table-column  label="用户身份" >
                  <template slot-scope="scope">
                  <div class="">
                    {{scope.row.role==1?'内部用户':'外部用户'}}
                  </div>
                  </template>
                </el-table-column>

                <el-table-column prop="InTime" label="注册时间" >
                </el-table-column>

                <el-table-column  label="操作" width="180">
                    <template slot-scope="scope">
                        <el-button size="small" type="success" :disabled="scope.row.status==1" @click="handleDelete(scope)">删除</el-button>
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
            this.tableData=this.backUpData.filter(v=>v.role!=val

            )
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
          handleUploadSuccess(v){
            if(v>0){
              this.$message.success(`上传题库成功!`);
              this.getData();
            }else{
              this.$message.error("文件删除出错!");
            }
          },
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
                    action:"getUsers"
                }).then((res)=> {
                    console.log(res);
                    this.backUpData = Array.from(res.data);
                    this.tableData = Array.from(res.data);
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
            DeleteAll() {
                const length = this.multipleSelection.length;

                if (length==0) {
                  this.$message.warning("所选项无效!");
                  return false;
                }
                this.handleDelete(this.multipleSelection);
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
            handleDelete(scope){
              if (!Array.isArray(scope)) {
                scope=[scope.row];
              }
              let _id=[];

              scope.map((v)=>{
                _id.push(v.id)
              })

              this.$axios.post(this.url,{
                action:"delete",
                id:_id
              }).then(res=>{
                if(res.data!=1){
                  this.$message.error(`删除失败!`);
                  return false;
                }
                let tempArray=this.backUpData;
                _id.map((v,k)=>{
                  this.backUpData.map((v1,k1)=>{
                    if (v==v1.id) {
                        tempArray.splice(k1,1)
                    }
                  })
                })



                this.backUpData=[...tempArray];
                this.tableData=[...tempArray]
                this.$message.success(`删除成功!`);
              }).catch(e=>{
                console.log(res)
            })
            },
            handleSelectionChange(val) {
              console.log(val)
                this.multipleSelection = val.filter(v=>v.id);
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
