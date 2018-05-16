<template >
  <div class="">
    <div class="login-box">

		<div class="box-con tran">

			<div class="login-con f-l">

				<div class="form-group">

					<input type="text" placeholder="邮箱/手机号码"/>

					<span class="error-notic">邮箱/手机号码不正确</span>

				</div>

				<div class="form-group">

					<input type="password" placeholder="密码">

					<span class="error-notic">密码不正确</span>

				</div>

				<div class="form-group">

					<button type="submit" class="tran pr">

						<a href="index.html" class="tran">登录</a>

					</button>

				</div>

				<div class="from-line"></div>

				<div class="form-group">

					<a href="javascript:;" class="move-signup a-tag tran blue-border">还没有帐号？免费注册</a>

				</div>

				<div class="form-group">

					<a href="javascript:;" class="move-reset a-tag tran">忘记密码？重置</a>

				</div>
			</div>

			<!-- 登录 -->

			<div class="signup f-l">

				<div class="form-group">

					<div class="signup-form">

						<input type="text" placeholder="邮箱" class="email-mobile" onblur="verify.verifyEmail(this)">

						<a href="javascript:;" class="signup-select">手机注册</a>

					</div>

					<span class="error-notic">邮箱格式不正确</span>

				</div>

				<div class="signup-email">

					<div class="form-group">

						<input type="text" placeholder="您的名字">

					</div>

					<div class="form-group">

						<input type="password" placeholder="密码（字母、数字，至少6位）" onblur="verify.PasswordLenght(this)">

						<span class="error-notic">密码长度不够</span>

					</div>

					<div class="form-group">

						<button type="submit" class="tran pr">

							<a href="javascript:;" class="tran">注册</a>

						</button>

					</div>

					<p class="view-clause">点击注册，即同意我们的 <a href="#">用户隐私条款</a></p>

				</div><!-- 邮箱注册 -->

				<div class="signup-tel" style="display:none">

					<div class="signup-form" id="message-inf" style="display:none">

						<input type="text" placeholder="短信验证码" style="width:180px;" onblur="verify.VerifyCount(this)">

						<a href="javascript:;" class="reacquire">重新获取（59）</a>

						<span class="error-notic">验证码输入错误</span>

					</div>

					<div class="form-group">

						<button type="submit" class="tran get-message pr">

							<a href="javascript:;" class="tran">获取短信验证码</a>

						</button>

					</div>

				</div><!-- 手机号码注册 -->

				<div class="from-line"></div>

				<div class="form-group">

					<a href="javascript:;" class="move-login a-tag tran blue-border">已有帐号？登录</a>

				</div>

			</div>

			<!-- 注册 -->


			<div class="mimachongzhi f-l">

				<div class="form-group">

					<input type="text" placeholder="请输入您的邮箱地址">

					<span class="error-notic">邮箱格式不正确</span>

				</div>

				<div class="form-group">

					<button type="submit" class="tran pr">

						<a href="javascript:;" class="tran">发送重置密码邮件</a>

					</button>

				</div>

				<div class="from-line"></div>

				<div class="form-group">

					<a href="javascript:;" class="move-signup	a-tag tran blue-border">还没有帐号？免费注册</a>

				</div>

				<div class="form-group">

					<a href="javascript:;" class="move-login a-tag tran">已有帐号？登录</a>

				</div>

			</div>

			<!-- 密码重置 -->



			<div class="mobile-success f-l">

				<p>手机号 <span>186****7580</span> 验证成功</p>

				<p>请完善您的账号信息，您也可以<a href="#">绑定现有账号</a></p>

				<div class="form-group">

					<input type="text" placeholder="邮箱" class="email-mobile" onblur="verify.verifyEmail(this)"/>

					<span class="error-notic">邮箱格式不正确</span>

				</div>

				<div class="form-group">

					<input type="text" placeholder="您的名字">

				</div>

				<div class="form-group">

					<input type="password" placeholder="密码（字母、数字，至少6位）" onblur="verify.PasswordLenght(this)"/>

					<span class="error-notic">密码长度不够</span>

				</div>

				<div class="form-group">

					<button type="submit" class="tran pr">

						<a href="javascript:;" class="tran">注册</a>

					</button>

				</div>

			</div>

			<!-- 手机注册成功添补信息 -->

		</div>

	</div>
  </div>
</template>
<script type="text/javascript">
  export default {
    data(){
      return{
        a:1
      }
    }
  }
</script>
