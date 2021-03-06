$(function() {
	// Waves初始化
	Waves.displayEffect();
	// 输入框获取焦点后出现下划线
	$('.form-control').focus(function() {
		$(this).parent().addClass('fg-toggled');
	}).blur(function() {
		$(this).parent().removeClass('fg-toggled');
	});
});
Checkbix.init();
$(function() {
	// 点击登录按钮
	$('#login-bt').click(function() {
		login();
	});
	// 回车事件
	$('#username, #password,#captcha').keypress(function (event) {
		if (13 == event.keyCode) {
			login();
		}
	});
});
// 登录
function login() {
	$.ajax({
		url: 'login',
		type: 'POST',
		data: {
			username: $('#username').val(),
			password: $('#password').val(),
            captcha:  $('#captcha').val()
		},
		beforeSend: function() {

		},
		success: function(json){
//			json = eval('(' + json + ')');
			if (json.code == 1) {
				location.href = "manage/index";
			} else {
				// alert(json.msg);
                layer.msg(json.msg);
				if (10000 == json.code) {
					$('#username').focus();
				}
				if (10001 == json.code) {
					$('#password').focus();
				}
                if (10002 == json.code) {
                    $('#captcha').focus();
                }
			}
		},
		error: function(error){
			console.log(error.msg);
		}
	});
}