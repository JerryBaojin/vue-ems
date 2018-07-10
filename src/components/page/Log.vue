<template>
    <div class="table">
        <div class="crumbs">
            <el-breadcrumb separator="/">
                <el-breadcrumb-item><i class="el-icon-tickets"></i> 日志</el-breadcrumb-item>
            </el-breadcrumb>
        </div>
        <div class="containera">


            <el-table  max-height="450" :data="data" border style="width: 100%" ref="multipleTable"  >
              <el-table-column type="selection" width="55"></el-table-column>
                <!-- <el-table-column prop="id" width="55" label="id"></el-table-column> -->
                <el-table-column prop="user" width="120" label="操作员">

                </el-table-column>
                <el-table-column prop="action" label="事件" >
                </el-table-column>
                <el-table-column prop="time" label="时间" width="300">
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
                url: 'api/sys.php',

                formLabelWidth:"250px",
                tableData: [],

                cur_page: 1,

                idx: -1
            }
        },
        watch:{

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
                    action:"getLog"
                }).then(res=> {

                    this.backUpData = res.data;
                    this.tableData = res.data;
                }).catch(e=>{

                  this.$message.error("网络传输错误!");
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
