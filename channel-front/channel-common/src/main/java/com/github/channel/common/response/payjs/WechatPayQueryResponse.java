package com.github.channel.common.response.payjs;

public class WechatPayQueryResponse extends PayJsResponse{

	private String mchid;			//string(32)	Y	PAYJS 平台商户号
	private String outTradeNo;	//string(32)	Y	用户端订单号
	private String payjsOrderId;	//string(32)	Y	PAYJS 订单号
	private String transactionId;	//string(32)	N	微信显示订单号
	private int status;				//int(1)	Y	0：未支付，1：支付成功
	private String openid;			//string(32)	N	用户 OPENID
	private int totalFee;			//int(16)	N	订单金额
	private String paidTime;		//string(32)	N	订单支付时间
	private String attach;			//string(127)	N	用户自定义数据
	public String getMchid() {
		return mchid;
	}
	public void setMchid(String mchid) {
		this.mchid = mchid;
	}
	public String getOutTradeNo() {
		return outTradeNo;
	}
	public void setOutTradeNo(String outTradeNo) {
		this.outTradeNo = outTradeNo;
	}
	public String getPayjsOrderId() {
		return payjsOrderId;
	}
	public void setPayjsOrderId(String payjsOrderId) {
		this.payjsOrderId = payjsOrderId;
	}
	public String getTransactionId() {
		return transactionId;
	}
	public void setTransactionId(String transactionId) {
		this.transactionId = transactionId;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public String getOpenid() {
		return openid;
	}
	public void setOpenid(String openid) {
		this.openid = openid;
	}
	public int getTotalFee() {
		return totalFee;
	}
	public void setTotalFee(int totalFee) {
		this.totalFee = totalFee;
	}
	public String getPaidTime() {
		return paidTime;
	}
	public void setPaidTime(String paidTime) {
		this.paidTime = paidTime;
	}
	public String getAttach() {
		return attach;
	}
	public void setAttach(String attach) {
		this.attach = attach;
	}
	
	
}
