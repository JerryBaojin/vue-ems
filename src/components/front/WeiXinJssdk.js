
import axios from 'axios';
import wx from 'weixin-js-sdk';
export default (dates)=>{
        let titleA=dates.title;
        let decA=dates.desc;
        let sharelinkAimgA=dates.image;
        let sharelink=dates.link;
        axios.post("api/frontapi.php",{"act":"JSSDK"}).then(res=>{
        let infos=  res.data.signPackage;
        if(!infos){
          return false;
        }
          wx.config({
            debug: false,
            appId: infos['appId'],
            timestamp: infos['timestamp'],
            nonceStr: infos['nonceStr'],
            signature:infos['signature'],
            jsApiList: [
              'onMenuShareTimeline',
              'onMenuShareAppMessage',
              'onMenuShareQQ',
              'onMenuShareWeibo',
              'onMenuShareQZone'
            ]
          });
        wx.ready(function () {
           wx.onMenuShareTimeline({  //分享到朋友圈
             title: titleA,//描述
             link: sharelink, // 分享链接
             imgUrl: sharelinkAimgA, // 分享图标
             success: function () {
              //alert("ok！");  // 用户确认分享后执行的回调函数
             },
             cancel: function () {
             // alert("取消了分享！"); // 用户取消分享后执行的回调函数
             }
           });
          wx.onMenuShareAppMessage({  //分享给好友
             title: titleA, // 分享标题
             desc: decA,//描述
             link: sharelink,// 分享链接
             imgUrl: sharelinkAimgA, // 分享图标
             success: function () {
              //alert("ok！");  // 用户确认分享后执行的回调函数
             },
             cancel: function () {
              //alert("取消了分享！"); // 用户取消分享后执行的回调函数
             }
           });
          wx.onMenuShareQQ({  //分享到QQ
             title: titleA, // 分享标题
             desc: decA,//描述
             link: sharelink, // 分享链接
             imgUrl: decA, // 分享图标
             success: function () {
              //alert("ok！");  // 用户确认分享后执行的回调函数
             },
             cancel: function () {
             // alert("取消了分享！"); // 用户取消分享后执行的回调函数
             }
           });
          wx.onMenuShareWeibo({  //分享到微博
             title: titleA, // 分享标题
             desc: decA,//描述
             link: sharelink, // 分享链接
             imgUrl: decA, // 分享图标
             success: function () {
              //alert("ok！");  // 用户确认分享后执行的回调函数
             },
             cancel: function () {
             // alert("取消了分享！"); // 用户取消分享后执行的回调函数
             }
           });
          wx.onMenuShareQZone({  //分享到QQ空间
             title: titleA, // 分享标题
             desc: decA,//描述
             link: sharelink, // 分享链接
             imgUrl: decA, // 分享图标
             success: function () {
              //alert("ok！");  // 用户确认分享后执行的回调函数
             },
             cancel: function () {
              //alert("取消了分享！"); // 用户取消分享后执行的回调函数
             }
           });
        });
      })
}
