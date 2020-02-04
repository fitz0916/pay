package com.github.channel.common.request.payjs;

import com.github.channel.common.domain.BaseObject;

public class WechatPayQuerySignRequest extends BaseObject{

	private String payjsOrderId;
	
	private String sign;
	
	public String getPayjsOrderId() {
		return payjsOrderId;
	}
	public void setPayjsOrderId(String payjsOrderId) {
		this.payjsOrderId = payjsOrderId;
	}
	public String getSign() {
		return sign;
	}
	public void setSign(String sign) {
		this.sign = sign;
	}
	
	
}
