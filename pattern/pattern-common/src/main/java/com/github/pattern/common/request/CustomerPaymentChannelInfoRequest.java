package com.github.pattern.common.request;

import com.github.appmodel.request.PageRequest;

public class CustomerPaymentChannelInfoRequest extends PageRequest{

	private Integer shopId;

	private Integer customerId;
	
	public Integer getShopId() {
		return shopId;
	}

	public void setShopId(Integer shopId) {
		this.shopId = shopId;
	}

	public Integer getCustomerId() {
		return customerId;
	}

	public void setCustomerId(Integer customerId) {
		this.customerId = customerId;
	}
	
	
}
