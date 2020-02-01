package com.github.pattern.common.request;

import com.github.appmodel.request.PageRequest;

public class CustomerRequest extends PageRequest{

	private Integer shopId;

	public Integer getShopId() {
		return shopId;
	}

	public void setShopId(Integer shopId) {
		this.shopId = shopId;
	}
	
	
}
