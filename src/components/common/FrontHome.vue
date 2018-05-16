<template >
  <div class="bg">
    <transition name="move">
        <router-view></router-view>
    </transition>
    <div class="footer">内江市纪委监委机关党委</div>
  </div>
</template>
<script type="text/javascript">
  import Index from '../front/index.vue';
  import Main from '../front/Main.vue';
  import Rank from '../front/Rank.vue';
  import Person from '../front/person.vue';
  import Pwd from '../front/pwd.vue';
  import Ponit from '../front/ponits.vue';
  export default {
    data(){
      return{

      }
    },
    components:{
        Index,Main,Rank,Person
    },
    mounted(){
      var userScalable = "no";
      var ins = "";
      (function () {
        if (window.devicePixelRatio === 1.5) {
          userScalable = "yes";
          ins = "initial-scale=0.5"
        }
        var text = "<meta content='" + ins + ", target-densitydpi=device-dpi, width=640,user-scalable=" + userScalable + "' name='viewport'>";
        document.write(text);
      })();
    }
  }
</script>
<style >
  @import '../../../static/css/css.css';
  .food {
    position: fixed;
    left: 0;
    top: 0;
    bottom: 48px;
    z-index: 30;
    width: 100%;
    background: #fff;
  }
  .food .move-enter-active, .food .move-leave-active {
    transition: all 0.5s linear;
    transform: translate3d(0, 0, 0);
  }
  .food .move-enter, .food .move-leave {
    transform: translate3d(100%, 0, 0);
  }

</style>
