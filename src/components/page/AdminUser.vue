<template>
    <div class="table">
        <div class="crumbs">
            <el-breadcrumb separator="/">
                <el-breadcrumb-item><i class="el-icon-tickets"></i> 用户</el-breadcrumb-item>
            </el-breadcrumb>
        </div>
        <div class="containera">
            <div class="handle-box">
                <el-button type="primary" icon="delete" class="handle-del mr10" @click="deleteAll">批量删除</el-button>
                <el-input v-model="select_word" placeholder="筛选管理员昵称称关键词" class="handle-input mr10"></el-input>
                <el-button type="primary" icon="search" @click="search">搜索</el-button>
                <el-button type="primary" icon="search" @click="add">新增管理员</el-button>
            </div>

            <el-table  max-height="450" :data="data" border ref="multipleTable" :row-class-name="tableRowClassname" @selection-change="handleSelection">
              <el-table-column type="selection" width="55"></el-table-column>
                <!-- <el-table-column prop="id" width="55" label="id"></el-table-column> -->
                <el-table-column prop="UID" width="120" label="管理员身份">
                    <template slot-scope="scope">
                      {{scope.row.role==="SA"?'系统管理员':'题库管理员'}}
                    </template>
                </el-table-column>
                <el-table-column prop="counter" label="管理员昵称" >
                </el-table-column>
                <el-table-column prop="phone" label="手机号" width="120">
                </el-table-column>

                <el-table-column  label="操作" width="180">
                    <template slot-scope="scope">
                        <el-button size="small" type="danger" :disabled="scope.row.status==1" @click="handleDelete(scope)">删除</el-button>
                        <el-button size="small" type="success" :disabled="scope.row.status==1" @click="handleEdit(scope)">修改</el-button>
                    </template>
                </el-table-column>
            </el-table>

            <div class="pagination">
                <el-pagination @current-change="handleCurrentChange" layout="prev, pager, next" :total="tableData.length">
                </el-pagination>
            </div>

            <el-dialog title="设置用户信息" :visible.sync="dialogFormVisible">
              <el-form :model="form">
                <el-form-item label="管理员名称" :label-width="formLabelWidth">
                  <el-input v-model="form.counter" auto-complete="off"></el-input>
                </el-form-item>
                <el-form-item label="管理员手机号" :label-width="formLabelWidth">
                  <el-input v-model="form.phone" auto-complete="off"></el-input>
                </el-form-item>
                <el-form-item label="管理员角色类型" :label-width="formLabelWidth">
                  <el-select v-model="form.role" placeholder="请选择管理员角色类型">
                    <el-option label="超级管理员" value="SA"></el-option>
                    <el-option label="题库管理员" value="QA"></el-option>
                  </el-select>
                </el-form-item>
              </el-form>
              <div slot="footer" class="dialog-footer">
                <el-button @click="dialogFormVisible = false">取 消</el-button>
                <el-button type="primary" @click="confirm">确 定</el-button>
              </div>
            </el-dialog>
        </div>
    </div>
</template>

<script>
    export default {
        data() {
            return {
                url: 'api/user.php',
                form:{
                  counter:"",
                  role:"",
                  phone:""
                },
                actionType:"delete",
                formLabelWidth:"250px",
                tableData: [],
                backUpData: [],
                select_word:"",
                cur_page: 1,
                multipleSelection: [],
                pass_list: [],
                dialogFormVisible: false,
                delVisible:false,
                visible2:false,
                is_search: false,
                idx: -1
            }
        },
        watch:{

          select_cate(val){
            this.tableData=this.backUpData.filter(v=>{
              if(val==0){
                return    v.oid==null;
              }else{
                return  v.oid!=null;
              }
            }

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

          confirm(){
            for(let x in this.form){
              if(this.form[x]===''){
                this.$message.error("请填写所有内容!");
                return false;
              }
            }
            if (!/^1[3|4|5|6|7|8][0-9]\d{8}$|^\d{8}$/.test(this.form.phone)) {
              alert("手机输入的格式错误!");
              return false;
            }
            this.$axios.post(this.url,{
              action:this.actionType==="delete"?"editUser":"add",
              ...this.form
            }).then(res=>{
              switch (res.data.code) {
                case 500:
                    this.$message.success("请稍后重试");
                  break;
                  case 204:
                    this.$message.error("更新失败!");
                    break;
                    case 403:
                    this.$message.error("手机号重复!")
                    break;
                  case 201:
                    if (res.data.id==0) {
                      this.$message.error("添加失败!");
                    }else{
                      this.$message.success("添加成功!");
                      this.getData();
                      this.dialogFormVisible=!this.dialogFormVisible;
                    }

                    break;
                  case 200:
                  this.$message.success("更新成功！");
                  this.getData();
                  this.dialogFormVisible=!this.dialogFormVisible;
                    break;
                default:

              }
              if (res.data.code) {


              }
            }).catch(e=>{
              console.log(e)
            })

          },
            add(){
              this.actionType="add";
                this.form={
                  counter:"",
                  role:"",
                  phone:""
                }
                  this.dialogFormVisible=true;
            },
            handleEdit(v){
              this.actionType="delete";
              this.form={...v.row};
              this.dialogFormVisible=true;
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
                    action:"getSysuser"
                }).then(res=> {
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
                this.tableData=this.backUpData.filter(v=> reg.test(v.phone))
            },
            filterTag(value, row) {
                return row.tag === value;
            },
            handleSelection(val) {
               this.multipleSelection = val.map(v=>{
                  return v.id
                })

            },
            deleteAll() {
                const length = this.multipleSelection.length;
                if (length==0) {
                  this.$message.warning("所选项无效!");
                  return false;
                }
                let __this=this;
                let str = '';
                this.pass_list = this.pass_list.concat(this.multipleSelection);

                this.$axios.post(this.url,{
                  action:"deleteUser",
                  id:this.pass_list
                }).then(res=>{

                  if(res.data==403){
                    this.$message.error(`不能删除admin用户!`);
                    return false;
                  }else if(res.data==0){
                    this.$message.error(`删除失败!`);
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
                    this.$message.success(`删除成功!`);
                }).catch(e=>{
                  console.log(res)
              })
                this.multipleSelection = [];
            },
            handleDelete(scope) {

                this.$axios.post(this.url,{
                  action:"deleteUser",
                  id:new Array(scope.row.id)
                }).then(res=>{
                  if(res.data==403){
                    this.$message.error(`不能删除admin用户!`);
                    return false;
                  }else if(res.data==0){
                    this.$message.error(`删除失败!`);
                  }
                  scope.row.status=1;

                  this.$set(this.tableData,scope.$index,scope.row)
                  this.backUpData.map((v,k)=>{
                    if(v.id==scope.row.id){
                           this.$set(this.tableData,k,scope.row)
                    }
                  })

                    this.$message.success(`删除成功!`);
                }).catch(e=>{
                  console.log(res)
              })
            }
            /*,
            handleSelectionChange(val) {
                this.multipleSelection = val.filter(v=>{ if (v.status==0) {return v.id;}}).map(v=>{return v.id});
            }*/

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
