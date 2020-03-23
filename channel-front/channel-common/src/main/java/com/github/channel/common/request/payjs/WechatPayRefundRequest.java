package com.github.channel.common.request.payjs;

public class WechatPayRefundRequest extends PayJsRequest {

	private String payjsOrderId;

	public String getPayjsOrderId() {
		return payjsOrderId;
	}

	public void setPayjsOrderId(String payjsOrderId) {
		this.payjsOrderId = payjsOrderId;
	}
}
