package com.github.trans.common.request;

import com.github.trans.common.domain.BaseObject;

public class PaymentOrderRequest extends BaseObject{

	private String customerNo;
	
	private String customerOrderNo;

	public String getCustomerNo() {
		return customerNo;
	}

	public void setCustomerNo(String customerNo) {
		this.customerNo = customerNo;
	}

	public String getCustomerOrderNo() {
		return customerOrderNo;
	}

	public void setCustomerOrderNo(String customerOrderNo) {
		this.customerOrderNo = customerOrderNo;
	}
	
	
}
