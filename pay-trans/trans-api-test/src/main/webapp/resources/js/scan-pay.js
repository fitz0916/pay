$(function(){
	$('#payBtn').bind('click',function(){
		submit();
	});
});
function submit(){
	var customerNo = $('#customerNo').val();
	var payAmount = $('#payAmount').val();
	var payType = $('#payType').val();
	var notifyUrl = $('#notifyUrl').val();
	var returnUrl = $('#returnUrl').val();
	var merKey = $('#merKey').val();
	var digiReg = /^[0-9]*$/;
	var amountReg = /^[0-9]+([.]{1}[0-9]{1,2})?$/;
	if(!digiReg.test(customerNo)){
		alert('请输入正确的商户号！');
		return;
	}
	if($.trim(merKey) == ''){
		alert('请输入商户秘钥！');
		return;
	}
	if(!amountReg.test(payAmount)){
		alert('请输入正确的支付金额！');
		return;
	}
	
	if($.trim(payType) == ''){
		alert('请选择交易类型！');
		return;
	}
	if($.trim(notifyUrl) == ''){
		alert('请输入异步回调地址！');
		return;
	}
	if($.trim(returnUrl) == ''){
		alert('请输入同步回调地址！');
		return;
	}
	$('#payform').submit();
}

