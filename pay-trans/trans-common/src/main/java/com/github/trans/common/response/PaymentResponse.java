package com.github.trans.common.response;

import org.apache.commons.lang3.builder.ReflectionToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

import com.github.trans.common.annotation.Signature;

public class PaymentResponse extends TransResponse{

	@Signature(required = true, desc = "二维码")
	private String qrCode;
	private String sign;
	@Signature(required = true, desc = "商户号")
	private String customerNo;
	@Signature(required = true, desc = "支付类型")
	private String payType;
	@Signature(required = true, desc = "交易订单号")
	private String payOrderNo;
	@Signature(required = true, desc = "交易金额")
	private String payAmount;
	@Signature(required = true, desc = "系统交易订单号")
	private String orderNo;
	
	public String getQrCode() {
		return qrCode;
	}
	public void setQrCode(String qrCode) {
		this.qrCode = qrCode;
	}
	public String getSign() {
		return sign;
	}
	public void setSign(String sign) {
		this.sign = sign;
	}
	public String getCustomerNo() {
		return customerNo;
	}
	public void setCustomerNo(String customerNo) {
		this.customerNo = customerNo;
	}
	public String getPayType() {
		return payType;
	}
	public void setPayType(String payType) {
		this.payType = payType;
	}
	public String getPayOrderNo() {
		return payOrderNo;
	}
	public void setPayOrderNo(String payOrderNo) {
		this.payOrderNo = payOrderNo;
	}
	public String getPayAmount() {
		return payAmount;
	}
	public void setPayAmount(String payAmount) {
		this.payAmount = payAmount;
	}
	public String getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}
	
	@Override
	public String toString() {
		return ReflectionToStringBuilder.toString(this,ToStringStyle.MULTI_LINE_STYLE);
	}
	
}
