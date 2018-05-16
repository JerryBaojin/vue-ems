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
                // },
                // {
                //     path: 'form',
                //     component: resolve => require(['../components/page/BaseForm.vue'], resolve),
                //     meta: { title: '基本表单' }

                // },
                // {
                //     // 富文本编辑器组件
                //     path: 'editor',
                //     component: resolve => require(['../components/page/VueEditor.vue'], resolve),
                //     meta: { title: '富文本编辑器' }
                // },
                // {
                //     // markdown组件
                //     path: 'markdown',
                //     component: resolve => require(['../components/page/Markdown.vue'], resolve),
                //     meta: { title: 'markdown编辑器' }
                // },
                // {
                //     // 图片上传组件
                //     path: 'upload',
                //     component: resolve => require(['../components/page/Upload.vue'], resolve),
                //     meta: { title: '文件上传' }
                // },
                // {
                //     // vue-schart组件
                //     path: 'charts',
                //     component: resolve => require(['../components/page/BaseCharts.vue'], resolve),
                //     meta: { title: 'schart图表' }
                // },
                // {
                //     // 拖拽列表组件
                //     path: 'drag',
                //     component: resolve => require(['../components/page/DragList.vue'], resolve),
                //     meta: { title: '拖拽列表' }
                // },
                // {
                //     // 权限页面
                //     path: '/permission',
                //     component: resolve => require(['../components/page/Permission.vue'], resolve),
                //     meta: { title: '权限测试', permission: true }
                // }
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
