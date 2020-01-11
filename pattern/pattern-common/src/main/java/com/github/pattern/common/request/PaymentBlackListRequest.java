package com.github.pattern.common.request;

public class PaymentBlackListRequest extends PageRequest{

	private Integer customerId;

	public Integer getCustomerId() {
		return customerId;
	}

	public void setCustomerId(Integer customerId) {
		this.customerId = customerId;
	}
	
	
}
