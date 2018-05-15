<template >
  <div class="bg">
    <transition name="move" mode="out-in">
        <router-view></router-view>
    </transition>
  </div>
</template>
<script type="text/javascript">
  import Index from '../front/index.vue';

  export default {
    data(){
      return{

      }
    },
    components:{
        Index
    }
  }
</script>
<style >
.bg {
  height: 100%;
	background: url(../../../static/img/index_bg.png) no-repeat;
	background-position: left top;
	background-size: 100%, cover;
	background-attachment: fixed;
	color: #FFFFFF;
	z-index: -1;
}
</style>
