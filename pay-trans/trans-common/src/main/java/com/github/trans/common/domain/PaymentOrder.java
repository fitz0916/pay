package com.github.trans.common.domain;

import java.math.BigDecimal;
import java.util.Date;

public class PaymentOrder extends BaseObject{
	//订单号
	private String orderNo;
	//商户号
	private String customerNo;
	//商户名称
	private String customerName;
	//代理商ID
	private Integer agentId;
	//代理商名称
	private Integer shopId;
	//三方渠道号
	private String thirdCustomerNo;
	//商户订单号
	private String customerOrderNo;
	//三方支付费率
	private String thirdChannelOrderNo;
	//支付类型
	private String payType;
	//支付状态0:初始化1：支付进行中 2：支付成功 3：支付失败
	private int payStatus;
	//订单生成时间
	private Date transTime;
	//订单交易完成时间
	private Date transFinishTime;
	//主题
	private String subject;
	//描述
	private String desc;
	//商户渠道ID
	private Integer customerPaymentChannelInfoId;
	//渠道ID
	private Integer paymentChannelId;
	//渠道账号ID
	private Integer paymentChannelAccountId;
	//后台回调地址
	private String notifyUrl;
	//前端回调地址
	private String returnUrl;
	//交易金额
	private Long payAmount; 
	//三方渠道费率
	private BigDecimal thirdChannelFee;
	//三方渠道收取手续费（分）
	private Long thirdChannelProundage;
	//销售费率
	private BigDecimal customerFee;
	//收取商户手续费用(分)
	private Long customerProundage;
	//代理商费率
	private BigDecimal agentFee;
	//代理商手续费(实际金额*在开通通道界面配置的费率)
	private Long agentProundage;
	//商户实际到账金额(交易金额-交易金额*接入费率)
	private Long customerAmount;
	//二维码地址
	private String qrCode;
	//结算类型 700:T0结算 701:T1结算  702:D0  703:D1
	private int settlementType;
	//结算状态0：未结算，1：已结算 2：结算失败
	private int settlementStatus;
	//币种
	private String currency;
	//客户端请求IP
	private String clientIp;

	public String getOrderNo() {
		return orderNo;
	}

	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}

	public String getCustomerNo() {
		return customerNo;
	}

	public void setCustomerNo(String customerNo) {
		this.customerNo = customerNo;
	}

	public String getCustomerName() {
		return customerName;
	}

	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}

	public Integer getAgentId() {
		return agentId;
	}

	public void setAgentId(Integer agentId) {
		this.agentId = agentId;
	}

	public Integer getShopId() {
		return shopId;
	}

	public void setShopId(Integer shopId) {
		this.shopId = shopId;
	}

	public String getThirdCustomerNo() {
		return thirdCustomerNo;
	}

	public void setThirdCustomerNo(String thirdCustomerNo) {
		this.thirdCustomerNo = thirdCustomerNo;
	}

	public String getCustomerOrderNo() {
		return customerOrderNo;
	}

	public void setCustomerOrderNo(String customerOrderNo) {
		this.customerOrderNo = customerOrderNo;
	}

	public String getThirdChannelOrderNo() {
		return thirdChannelOrderNo;
	}

	public void setThirdChannelOrderNo(String thirdChannelOrderNo) {
		this.thirdChannelOrderNo = thirdChannelOrderNo;
	}

	public String getPayType() {
		return payType;
	}

	public void setPayType(String payType) {
		this.payType = payType;
	}

	public int getPayStatus() {
		return payStatus;
	}

	public void setPayStatus(int payStatus) {
		this.payStatus = payStatus;
	}

	public Date getTransTime() {
		return transTime;
	}

	public void setTransTime(Date transTime) {
		this.transTime = transTime;
	}

	public Date getTransFinishTime() {
		return transFinishTime;
	}

	public void setTransFinishTime(Date transFinishTime) {
		this.transFinishTime = transFinishTime;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getDesc() {
		return desc;
	}

	public void setDesc(String desc) {
		this.desc = desc;
	}

	public Integer getCustomerPaymentChannelInfoId() {
		return customerPaymentChannelInfoId;
	}

	public void setCustomerPaymentChannelInfoId(Integer customerPaymentChannelInfoId) {
		this.customerPaymentChannelInfoId = customerPaymentChannelInfoId;
	}

	public Integer getPaymentChannelId() {
		return paymentChannelId;
	}

	public void setPaymentChannelId(Integer paymentChannelId) {
		this.paymentChannelId = paymentChannelId;
	}

	public Integer getPaymentChannelAccountId() {
		return paymentChannelAccountId;
	}

	public void setPaymentChannelAccountId(Integer paymentChannelAccountId) {
		this.paymentChannelAccountId = paymentChannelAccountId;
	}

	public String getNotifyUrl() {
		return notifyUrl;
	}

	public void setNotifyUrl(String notifyUrl) {
		this.notifyUrl = notifyUrl;
	}

	public String getReturnUrl() {
		return returnUrl;
	}

	public void setReturnUrl(String returnUrl) {
		this.returnUrl = returnUrl;
	}

	public Long getPayAmount() {
		return payAmount;
	}

	public void setPayAmount(Long payAmount) {
		this.payAmount = payAmount;
	}

	public BigDecimal getThirdChannelFee() {
		return thirdChannelFee;
	}

	public void setThirdChannelFee(BigDecimal thirdChannelFee) {
		this.thirdChannelFee = thirdChannelFee;
	}

	public Long getThirdChannelProundage() {
		return thirdChannelProundage;
	}

	public void setThirdChannelProundage(Long thirdChannelProundage) {
		this.thirdChannelProundage = thirdChannelProundage;
	}

	public BigDecimal getCustomerFee() {
		return customerFee;
	}

	public void setCustomerFee(BigDecimal customerFee) {
		this.customerFee = customerFee;
	}

	public Long getCustomerProundage() {
		return customerProundage;
	}

	public void setCustomerProundage(Long customerProundage) {
		this.customerProundage = customerProundage;
	}

	public BigDecimal getAgentFee() {
		return agentFee;
	}

	public void setAgentFee(BigDecimal agentFee) {
		this.agentFee = agentFee;
	}

	public Long getAgentProundage() {
		return agentProundage;
	}

	public void setAgentProundage(Long agentProundage) {
		this.agentProundage = agentProundage;
	}

	public Long getCustomerAmount() {
		return customerAmount;
	}

	public void setCustomerAmount(Long customerAmount) {
		this.customerAmount = customerAmount;
	}

	public String getQrCode() {
		return qrCode;
	}

	public void setQrCode(String qrCode) {
		this.qrCode = qrCode;
	}

	public int getSettlementType() {
		return settlementType;
	}

	public void setSettlementType(int settlementType) {
		this.settlementType = settlementType;
	}

	public int getSettlementStatus() {
		return settlementStatus;
	}

	public void setSettlementStatus(int settlementStatus) {
		this.settlementStatus = settlementStatus;
	}

	public String getCurrency() {
		return currency;
	}

	public void setCurrency(String currency) {
		this.currency = currency;
	}

	public String getClientIp() {
		return clientIp;
	}

	public void setClientIp(String clientIp) {
		this.clientIp = clientIp;
	}
	
	
	
	
}
