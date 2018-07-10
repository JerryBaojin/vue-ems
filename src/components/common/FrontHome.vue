<template >
  <div class="bg">
    <transition  :name="transitionName">
        <router-view></router-view>
    </transition>

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
          transitionName:''
      }
    },
    components:{
        Index,Main,Rank,Person
    },
    watch:{
      $route(to, from) {
        //如果to索引大于from索引,判断为前进状态,反之则为后退状态
        if(to.meta.index > from.meta.index){
          //设置动画名称
      //    this.transitionName = 'slide-left';
        }else{
        //  this.transitionName = 'slide-right';
        }
      }
    },
    mounted(){

    }
  }
</script>
<style >
  @import '../../../static/css/css.css';
  .slide-right-enter-active,
.slide-right-leave-active,
.slide-left-enter-active,
.slide-left-leave-active {
  will-change: transform;
  transition: all 500ms;
  position: absolute;
}
.slide-right-enter {
  opacity: 0;
  transform: translate3d(-100%, 0, 0);
}
.slide-right-leave-active {
  opacity: 0;
  transform: translate3d(100%, 0, 0);
}
.slide-left-enter {
  opacity: 0;
  transform: translate3d(100%, 0, 0);
}
.slide-left-leave-active {
  opacity: 0;
  transform: translate3d(-100%, 0, 0);
}
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
  .el-input{
    width: unset !important;
  }

</style>
