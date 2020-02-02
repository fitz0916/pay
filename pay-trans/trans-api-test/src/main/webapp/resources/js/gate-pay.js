$(function(){
	$('#payBtn').bind('click',function(){
		submit();
	});
});
function submit(){
	var merId = $('#merId').val();
	var amount = $('#amount').val();
	var urlBack = $('#urlBack').val();
	var urlJump = $('#urlJump').val();
	var merKey = $('#merKey').val();
	var digiReg = /^[0-9]*$/;
	var amountReg = /^[0-9]+([.]{1}[0-9]{1,2})?$/;
	if(!digiReg.test(merId)){
		alert('请输入正确的商户号！');
		return;
	}
	if($.trim(merKey) == ''){
		alert('请输入商户秘钥！');
		return;
	}
	if(!amountReg.test(amount)){
		alert('请输入正确的支付金额！');
		return;
	}
	if($.trim(urlBack) == ''){
		alert('请输入异步回调地址！');
		return;
	}
	if($.trim(urlJump) == ''){
		alert('请输入同步回调地址！');
		return;
	}
	$('#payform').submit();
}

