package com.github.channel.common.response.payjs;

public class WechatPayRefundResponse extends PayJsResponse {

	private String mchid;			//string(32)	Y	PAYJS 平台商户号
	private String outTradeNo;	//string(32)	Y	用户端订单号
	private String payjsOrderId;	//string(32)	Y	PAYJS 订单号
	private String transactionId;	//string(32)	N	微信显示订单号
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

}
