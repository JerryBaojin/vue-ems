<template>
    <div class="table">
        <div class="crumbs">
            <el-breadcrumb separator="/">
                <el-breadcrumb-item><i class="el-icon-tickets"></i> 试题题库</el-breadcrumb-item>
            </el-breadcrumb>
        </div>
        <div class="containera">

            <div class="handle-box">
                <el-button type="primary" icon="delete" class="handle-del mr10" @click="delAll">批量删除</el-button>
                <el-button type="primary" icon="delete"  :disabled="chooseQ" class="handle-del mr10" @click="handleChoose">
                 批量入选题库
                 </el-button>
                 <el-button type="primary" icon="delete"  :disabled="chooseQ" class="handle-del mr10" @click="handleRemove">
                  批量剔除题库
                  </el-button>

                <el-select v-model="select_cate" placeholder="筛选类型" class="handle-select mr10">
                    <el-option key="1" label="单选" value="单选"></el-option>
                    <el-option key="2" label="多选" value="多选"></el-option>
                </el-select>
                <el-input v-model="select_word" placeholder="筛选问题关键词" class="handle-input mr10"></el-input>
                <el-button type="primary" icon="search" @click="search">搜索</el-button>
                <el-button type="primary" @click="dialogVisible = true">点击上传题库</el-button>

                <el-dialog
                  title="上传题库"
                  :visible.sync="dialogVisible"
                  width="30%"
                >
                <div style="margin-bottom: 20px;">
                    <el-input placeholder="添加分类"  v-model="v_addQuizTypes" class="input-with-select">
                       <el-select v-model="currentQuiz_types"   slot="prepend" placeholder="选择分类">
                          <el-option v-for="(v,k) in quiz_types" :key="k" :label="v" :value="v"></el-option>
                       </el-select>
                     <el-button slot="append" @click="addQuizTypes" icon="el-icon-plus"></el-button>
                   </el-input>
                </div>

                <div class="">
                  <span>
                    <el-upload
                      class="upload-demo"
                      :action="url"
                      :headers="fileUploadHeader"
                      :on-success="handleUploadSuccess"
                      accept=".csv"
                      :limit="1"
                      :file-list="uploadedFiles"
                      >
                      <el-button size="small" type="primary" >点击选择上传题库文件</el-button>
                      <div slot="tip" class="el-upload__tip">只能上传csv文件，且不超过5m</div>
                      </el-upload>
                  </span>
                  <span slot="footer" class="dialog-footer">
                    <el-button @click="dialogVisible = false">关闭</el-button>
                    <el-button type="primary" @click="dialogVisible = false">确 定</el-button>
                  </span>
                </div>

                </el-dialog>

            </div>
            {{countChoosed>0?`已选择了:${countChoosed}项`:""}} <span class="" v-if="!chooseQ">当前已入选{{selectedOps}}项道题目</span>
            <el-table  max-height="650" :data="data" border :row-key="getRowKeys" style="width: 100%" ref="multipleTable" @selection-change="handleSelectionChange">
              <el-table-column type="selection" :reserve-selection="true" width="55"></el-table-column>
                <el-table-column prop="id" width="55" label="id"></el-table-column>
                <el-table-column prop="question" label="问题" width="120">
                </el-table-column>
                <el-table-column prop="answer" label="选项" >
                </el-table-column>
                <el-table-column prop="correct" label="正确答案" >
                </el-table-column>
                <el-table-column prop="type" label="题型" >
                </el-table-column>
                <el-table-column prop="qType" label="类型" >
                </el-table-column>
                <el-table-column   label="是否已入选题库" >
                      <template slot-scope="scope">
                       <el-popover
                          placement="top-start"
                          width="200"
                          trigger="hover"
                          :content="scope.row.isChecked==1?'点击从入选的测试题库剔除该题':'添加该题到测试题库'">
                          <el-button  :disabled="chooseQ" slot="reference" :type="scope.row.isChecked==1?'success':'warnning'" @click="chanedChecking(scope.$index, scope.row,scope.row.isChecked)">{{scope.row.isChecked=="1"?"已入选":"未入选"}}</el-button>
                        </el-popover>

                      </template>
                </el-table-column>
                <el-table-column label="操作" width="180">
                    <template slot-scope="scope">
                        <el-button size="small" @click="handleEdit(scope.$index, scope.row)">编辑</el-button>
                        <el-button size="small" type="danger" @click="handleDelete(scope.$index, scope.row)">删除</el-button>
                    </template>
                </el-table-column>
            </el-table>
            <div class="pagination">
                <el-pagination @current-change="handleCurrentChange" layout="prev, pager, next" :total="tableData.length">
                </el-pagination>
            </div>
        </div>

        <!-- 编辑弹出框 -->
        <el-form>
        <el-dialog title="编辑" :visible.sync="editVisible" width="30%">
            <el-form ref="form" :model="form" label-width="50px">
                <el-form-item label="问题">
                    <el-input type="textarea" v-model="form.question"></el-input>
                  </el-form-item>
                  <el-form-item label="选项">
                      <div class="items"v-for="(items,key) in tempFormDates.options">
                        <span>{{items[0]}}</span>
                        <el-input
                          minlength="1"
                          type="textarea"
                          autosize
                          v-model="items[1]"
                        >
                        </el-input>
                      </div>
                  </el-form-item>
                <el-form-item label="答案">
                      <el-checkbox-group class="options"  v-model="tempFormDates.checkedLists">
                        <div  v-for="items in tempFormDates.options">
                          <el-checkbox :label="items[0]"   border></el-checkbox>
                        </div>
                       </el-checkbox-group>
                </el-form-item>
            </el-form>
            <span slot="footer" class="dialog-footer">
                <el-button @click="editVisible = false">取 消</el-button>
                <el-button type="primary" @click="saveEdit">确 定</el-button>
            </span>
        </el-dialog>
      </el-form>
        <!-- 删除提示框 -->
        <el-dialog title="提示" :visible.sync="delVisible" width="300px" center>
            <div class="del-dialog-cnt">删除不可恢复，是否确定删除？</div>
            <span slot="footer" class="dialog-footer">
                <el-button @click="delVisible = false">取 消</el-button>
                <el-button type="primary" @click="deleteRow">确 定</el-button>
            </span>
        </el-dialog>
    </div>
</template>

<script>
    export default {
        data() {
            return {
                getRowKeys(row){
                  return row.id;
                },
                sysconfig:[],
                url: 'api/index.php',
                tableData: [],
                backUpData: [],
                uploadedFiles:[],
                cur_page: 1,
                multipleSelection: [],
                select_cate: '',
                select_word: '',
                del_list: [],
                dialogVisible: false,
                visible2:false,
                is_search: false,
                editVisible: false,
                delVisible: false,
                form: {
                    answer:'',
                    correct:'',
                    question:'',
                    type:''
                },
                tempFormDates:{
                  checkedLists:[],
                  options:[]
                },
                idx: -1,
                totalSelect:[],
                v_addQuizTypes:'',
                _id:-1,
                chooseQ:true,
                currentQuiz_types:"默认",
                quiz_types:["默认"]
            }
        },
        watch:{
          select_cate(val){

            this.tableData=this.backUpData.filter(v=>{

              return   v.type==val
            })
            this.tableData.length<=10?this.cur_page=1:null;
          }
        },
        created() {
            this.getData();
        },
        computed: {
          fileUploadHeader(){
            return {
              "qTypes":this.toUnicodeFun(this.currentQuiz_types),
              "token":this.$store.state.nowLogin.role
            }
          },
          selectedOps(){
            return this.backUpData.filter((v)=>v.isChecked==1).length;
          },
            data() {
                  return this.tableData.slice((this.cur_page-1)*10,this.cur_page*10)
            },
            countChoosed(){
              return this.multipleSelection.length;
            }
        },
        methods: {
          toUnicodeFun(data){
            var str ='';
           for(var i=0;i<data.length;i++){
              str+="\\u"+data.charCodeAt(i).toString(16);
           }
           return str;
          },
          addQuizTypes(){
            this.$confirm("确认添加此类型吗?","提示",{
              confirmButtonText: '确定',
              cancelButtonText: '取消',
              type: 'warning'
            }).then(res=>{

              this.quiz_types=[...this.quiz_types,this.v_addQuizTypes];
              this.$message({
                type:"success",
                message:"添加成功!"
              })
                      this.v_addQuizTypes='';
              this.$axios.post(this.url,{
                action:"updateQuizConfig",
                msg:`添加了${this.v_addQuizTypes}分类`,
                moreDate:this.quiz_types
              })
            }).catch(()=>{
              this.message({
                type:"info",
                message:"已取消添加!"
              })
            })


          },
          chanedChecking(pid,row,status){
            if(confirm("确认此操作吗?")){
              let p=0;
              status==1?p="0":p="1";
              this.changeChecking(row.id,p)
            }
          },
          changeChecking(dates,status){
            let date=dates;
            if((typeof dates)=='string'){
              date=new Array(dates);
            }else if((typeof date)=="object"){
              date=Array.from(dates)
            }
            this.$axios.post(this.url,{
              action:"changeChecking",
              ids:date,
              status:status
            }).then(res=>{
                if(res.data==1){
                  this.$message.success("修改成功!");
                  this.syncVueDates(date,status);
                }
            }).catch(e=>{
              this.$message.error("网络错误!")
            })
          },
          handleRemove(){
            this.changeChecking(this.multipleSelection,"0");
          },
          syncVueDates(date,cStatus){
            let __backUpData=this.backUpData;
            let __tableDate=this.tableData;

            date.map(ids=>{
                __backUpData.map((v,k)=>{
                  if(v.id==ids){
                    __backUpData[k]['isChecked']=cStatus;
                  }
                })
                __tableDate.map((v,k)=>{
                  if(v.id==ids){
                    __tableDate[k]['isChecked']=cStatus;
                  }
                })
            })

            this.backUpData=__backUpData;
            this.tableData=__tableDate;
          },
          handleChoose(){
              if(this.multipleSelection.length==0){
                this.showTips("选题提醒",`需要选择${this.sysconfig.timu}道题`)
              }else if (this.multipleSelection.length!=this.sysconfig.timu) {
                let syncDates=this.multipleSelection.length-this.sysconfig.timu;
                    syncDates>0?this.$message.error("多选了"+Math.abs(syncDates)+"道题,请删除部分!"):this.$message.error("少选了"+Math.abs(syncDates)+"道题,请添加"+Math.abs(syncDates)+"道题");
              }else{
                this.$axios.post(this.url,{
                  action:"recordTypes",
                  datas:[...this.multipleSelection]
                }).then(res=>{
                  if(res.data==1){
                    this.$message.success("已成功入选"+this.multipleSelection.length+"道题");
                    this.syncVueDates([...this.multipleSelection],"1");
                  }else{
                    this.$message.error("网络异常");
                  }
                }).catch(e=>{
                  this.$message.error("网络异常");
                })
              }
          },
          showTips(title,contents){
            const h=this.$createElement;
            this.$notify({
              title: title,
              message: h('i', { style: 'color: teal'},contents),
              duration: 5000
            });
          },
          handleUploadSuccess(v){
            if(v>0){
              this.$message.success(`上传题库成功!`);
              this.getData();
            }else{
              this.$message.error("文件上传出错!");
            }
          },
          handleCurrentChange(val) {
              this.cur_page = val;
          },
          getData() {
                this.$axios.post(this.url, {
                    action:"getQuestions",
                    page: this.cur_page
                }).then((res) => {
                    this.backUpData = [...res.data];
                    this.tableData = res.data;
                })
            },
            search() {
                this.is_search = true;
                let reg=new RegExp(this.select_word)
              this.tableData=this.backUpData.filter(v=> reg.test(v.options) || reg.test(v.question))
            },
            filterTag(value, row) {
                return row.tag === value;
            },
            handleEdit(index, row) {
              console.log(row);
                row.correct.length!=1?this.tempFormDates['checkedLists']=row.correct.split(","):this.tempFormDates['checkedLists']=[row.correct];
                this.tempFormDates['options']=new Array();
                let answers=row['answer'].split(/###[A-Z]./);

                answers=answers.slice(1,answers.length);

                answers.map((value,key)=>{
                      this.tempFormDates['options'].push([convert(key+1),value]);
                })

              //  row['options']=row['answer'].split("###");
                this.form = {...row};
                this.idx = row.id;
                this.editVisible = true;
                function convert(num){
                  let s="A";
                  switch (num) {
                    case 1:
                      s="A";
                      break;
                    case 2:
                      s="B";
                      break;
                      case 3:
                        s="C";
                        break;
                        case 4:
                          s="D";
                          break;
                          case 5:
                            s="E";
                            break;
                            case 6:
                              s="F";
                              break;
                    default:

                  }
                  return s;
                }
            },
            handleDelete(index, row) {
                this.idx = index;
                this._id=row.id;
                this.delVisible = true;
            },
            delAll() {
                const length = this.multipleSelection.length;
                let __this=this;
                let str = '';
                this.del_list = this.del_list.concat(this.multipleSelection);

                this.$axios.post(this.url,{
                  action:"delete",
                  details:this.del_list
                }).then(res=>{
                  if(res.data!=1){
                    this.$message.error(`删除失败!`);
                    return false;
                  }
                  __this.del_list.map((v)=>{
                    __this.tableData.splice(__this.tableData.findIndex(value=>value.id==v),1);
                    __this.backUpData.splice(__this.backUpData.findIndex(value=>value.id==v),1)
                  })

                    this.$message.success(`删除成功!`);
                }).catch(e=>{
                  console.log(res)
              })
                this.multipleSelection = [];
            },
            handleSelectionChange(val) {
               this.multipleSelection = val.map(v=>{
                  return v.id
                })

            },
            // 保存编辑
            saveEdit() {
              let flag=true;
              let __this=this;
              this.form.answer=this.tempFormDates.options.reduce((v,p)=>{
                if(Array.isArray(v)){
                  if(v[1]=='' || p[1]==''){
                    flag=false;
                  }
                    return v.join(".")+"###"+p.join(".");
                }else{
                  if(p[1]==''){
                    flag=false;
                  }
                    return v+"###"+p.join(".");
                }
              });
              this.form.answer="###"+this.form.answer;
              this.form.correct=this.tempFormDates.checkedLists.join(",");
              if(flag){
                if(this.form.correct.length>=2){
                  this.form.type="多选";
                  this.form.types="muti";
                }else{
                  if (/正确|错误/.test(this.form.answer)) {
                      this.form.type="判断";
                      this.form.types="jungle";
                  }else{
                      this.form.type="单选";
                      this.form.types="single";
                  }

                }
                                this.editVisible = false;
                                this.$axios.post(this.url,{
                                  action:"update",
                                  details:this.form
                                }).then(res=>{
                                    this.$message.success(`修改第 ${this.idx} 号成功`);
                                    const index=this.backUpData.findIndex(v=>v.id==this.idx);
                                    this.$set(this.tableData, this.tableData.findIndex(v=>v.id==this.idx), this.form);
                                    this.$set(this.backUpData,index, this.form);
                                }).catch(e=>{
                                  console.log(res)
                              })
              }else{
                    this.$message.error(`请填写所有选项的内容`);
              }



            },
            // 确定删除
            deleteRow(){
              let __this=this;
              this.$axios.post(this.url,
              {
                action:"delete",
                details:new Array(this.tableData[this.idx].id)
              }).then(res=>{
                if (res.data==1) {
                  this.tableData.splice(this.idx, 1);
                  this.backUpData.splice(this.backUpData.findIndex(v=>v.id==__this._id),1);
                  this.$message.success('删除成功');
                }
              }).catch(e=>{
                this.$message.error('删除失败');
              })
                        this.delVisible = false;
            }
          },
          mounted(){
            this.$axios.all([
              this.$axios.post("api/sys.php",{
                action:"getConfig"
              }),
              this.$axios.post("api/index.php",{
                action:"getQuizConfig"
              })
            ]).then(this.$axios.spread((res, res1)=>{

              this.sysconfig={...res.data};
              res.data.delivery=="false"?this.chooseQ=true:this.chooseQ=false;

              this.quiz_types=JSON.parse(res1.data.types);
            })
          )
            /*
            .then(res=>{

            }).catch(e=>{
              this.$message.error("网络传输错误!")
            })*/
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
    .el-select .el-input {
  width: 130px;
}
    .selectArea{
      display: flex;
    }
    .selectArea div{
      flex: 1;
    }
</style>
