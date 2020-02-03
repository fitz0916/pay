package com.github.channel.common.request;

import com.github.channel.common.domain.ChannelRequest;

public class WechatPayQueryRequest extends ChannelRequest{

	private String payjsOrderId;

	public String getPayjsOrderId() {
		return payjsOrderId;
	}

	public void setPayjsOrderId(String payjsOrderId) {
		this.payjsOrderId = payjsOrderId;
	}
}
