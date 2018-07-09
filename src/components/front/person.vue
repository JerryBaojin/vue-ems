<template >
  <div class="mall_main">
			<div id="child_header">
				<div class="goback">
					<router-link to="index"><i></i></router-link>
				</div>
				<div class="current_location"><span>个人中心</span></div>
			</div>
			<div class="wx_wrap">

					<div class="person_top">
						<div class="per_con">
							<div class="user_photo">
								<img :src="info.headImg">
								<span><strong>{{info.dirName}}</strong></span>
							</div>
							<div class="name_right">
								<p class="p1">会员昵称：{{info.nickname}}</p>
								<p>获得称号：{{info.level}}</p>
								<p class="p2">我的积分：{{info.scores}}</p>
								<p>答题数：{{info.counts}}</p>
							</div>
						</div>
					</div>

				<div class="set_up">
					<ul class="menu_list">
						<li class="tiao">
              <router-link to="pwd">修改昵称</router-link>
						</li>
						<li class="tiao">
              <router-link to="ponit">我的积分</router-link>
						</li>
					</ul>
				</div>
			</div>
		</div>
</template>

<script type="text/javascript">
  export default {
    data(){
      return{
          url:"api/frontUser.php",
          info:{}
      }
    },
    mounted(){
        this.$axios.post(this.url,{action:"getUserInfo",uid:JSON.parse(localStorage.getItem('wxUser-jw')).__Uinfos
.uid}).then(res=>{this.info=res.data})
    }
  }
</script>
