package com.github.trans.common.response;

import com.github.trans.common.annotation.Signature;

public class PaymentQueryResponse extends TransResponse{

	@Signature(required = true, desc = "商户号")
	private String customerNo;
	@Signature(required = true, desc = "交易订单号")
	private String payOrderNo;
	@Signature(required = true, desc = "支付状态")
	private String payStatus;
	
	private String sign;
	

	public String getCustomerNo() {
		return customerNo;
	}

	public void setCustomerNo(String customerNo) {
		this.customerNo = customerNo;
	}

	public String getPayOrderNo() {
		return payOrderNo;
	}

	public void setPayOrderNo(String payOrderNo) {
		this.payOrderNo = payOrderNo;
	}

	
	public String getPayStatus() {
		return payStatus;
	}

	public void setPayStatus(String payStatus) {
		this.payStatus = payStatus;
	}

	public String getSign() {
		return sign;
	}

	public void setSign(String sign) {
		this.sign = sign;
	}
	
	
}
