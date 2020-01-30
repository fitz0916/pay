package com.github.channel.common.request;

public class AliPayRequest extends PayJsRequest{
	//支付宝交易传值：alipay ，微信支付无需此字段
	private String type = "alipay";

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	

}
