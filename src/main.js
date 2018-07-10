import Vue from 'vue';
import App from './App';
import router from './router';
import axios from 'axios';
import ElementUI from 'element-ui';
import 'element-ui/lib/theme-chalk/index.css';    // 默认主题
import "babel-polyfill";
import store from './vuex/store'

Vue.use(ElementUI, { size: 'small' });

Vue.prototype.$axios = axios;

//使用钩子函数对路由进行权限跳转
router.beforeEach((to, from, next) => {
    const role = localStorage.getItem('ms_username');
    const ua = localStorage.getItem('role');
    const frontUser=  localStorage.getItem("wxUser-jw") || null;

    if(/front/.test(to.path)){
      if (/front\/login/.test(to.path)) {
        next();
      }else if (!frontUser) {
        location.href="http://wx1.scnjnews.com/dati/api/useropenid.php";
      }else {
        next();
      }
    // next();
    }else if(!role && to.path !== '/login'){

       next('/login');
    }else if(to.meta.permission){
      Vue.prototype.$axios.defaults.transformRequest=[function(x){
        return JSON.stringify({...x,nowUserrole:role})
      }]
        // 如果是管理员权限则可进入，这里只是简单的模拟管理员权限而已
        if (ua=="SA") {
          next();
        }else if (to.meta.permission==ua) {
          next();
        }else{
          next('/403');
        }


    }else{
        // 简单的判断IE10及以下不进入富文本编辑器，该组件不兼容
        if(navigator.userAgent.indexOf('MSIE') > -1 && to.path === '/editor'){
            Vue.prototype.$alert('vue-quill-editor组件不兼容IE10及以下浏览器，请使用更高版本的浏览器查看', '浏览器不兼容通知', {
                confirmButtonText: '确定'
            });
        }else{
          Vue.prototype.$axios.defaults.transformRequest=[function(x){
            return JSON.stringify({...x,nowUserrole:role})
          }]
            next();
        }
    }
})

new Vue({
    mode:"history",
    base:"/dati/",
    router,
    store,
    render: h => h(App)
}).$mount('#app');
