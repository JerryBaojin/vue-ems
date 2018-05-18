import Vue from 'vue';
import Router from 'vue-router';

Vue.use(Router);

export default new Router({
    routes: [
        {
            path: '/',
            redirect: '/admin/dashboard'
        },
        {
            path: '/admin',
            component: resolve => require(['../components/common/Home.vue'], resolve),
            meta: { title: '自述文件' },
            children:[
                {
                    path: 'dashboard',
                    component: resolve => require(['../components/page/Dashboard.vue'], resolve),
                    meta: { title: '系统首页' }
                },
                {
                    path: 'sysstting',
                    component: resolve => require(['../components/page/SysSetting.vue'], resolve),
                    meta: { title: '系统设置' }
                },
                {
                    path: 'table',
                    component: resolve => require(['../components/page/BaseTable.vue'], resolve),
                    meta: { title: '试题题库' }
                },
                {
                    path: 'tabs',
                    component: resolve => require(['../components/page/Tabs.vue'], resolve),
                    meta: { title: '用户管理' }
                },
                {
                    path: 'scores',
                    component: resolve => require(['../components/page/scores.vue'], resolve),
                    meta: { title: '积分管理' }
                  }
            ]
        },
        {
        path: '/front',
        meta: { title: '用户答题' },
        component: resolve => require(['../components/common/FrontHome.vue'], resolve),
        children:[
            {
                path: 'index',
                component: resolve => require(['../components/front/index.vue'], resolve),
                meta: { title: '选择页面' }
            },
            {
                path: 'main',
                name: 'main',
                component: resolve => require(['../components/front/Main.vue'], resolve),
                meta: { title: '答题页面' }
            },
            {
                path: 'rank',
                name: 'rank',
                component: resolve => require(['../components/front/Rank.vue'], resolve),
                meta: { title: '积分排行' }
            },
            {
                path: 'person',
                name: 'person',
                component: resolve => require(['../components/front/person.vue'], resolve),
                meta: { title: '个人中心' }
            },
            {
                path: 'ponit',
                name: 'ponit',
                component: resolve => require(['../components/front/ponits.vue'], resolve),
                meta: { title: '我的积分' }
            },
            {
                path: 'pwd',
                name: 'pwd',
                component: resolve => require(['../components/front/pwd.vue'], resolve),
                meta: { title: '修改密码' }
            },
            {
                path: 'login',
                component: resolve => require(['../components/front/login.vue'], resolve),
                meta: { title: '注册页面' }
            }
          ]
          },
        {
            path: '/login',
            component: resolve => require(['../components/page/Login.vue'], resolve)
        },
        {
            path: '/404',
            component: resolve => require(['../components/page/404.vue'], resolve)
        },
        {
            path: '/403',
            component: resolve => require(['../components/page/403.vue'], resolve)
        }
        ,
        {
            path: '*',
            redirect: '/404'
        }
    ]
})
