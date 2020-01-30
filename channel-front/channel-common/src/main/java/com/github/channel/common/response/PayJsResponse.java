package com.github.channel.common.response;

import com.github.channel.common.domain.ChannelResponse;

public class PayJsResponse extends ChannelResponse{
	
	private String returnCode;
	//返回消息
	private String returnMsg;
	//PAYJS 平台订单号
	private String payjsOrderId;
	//用户生成的订单号原样返回
	private String outTradeNo;	
	//金额。单位：分
	private int totalFee;
	//二维码图片地址
	private String qrcode;	
	//可将该参数生成二维码展示出来进行扫码支付(有效期2小时)
	private String codeUrl;	
	//数据签名 详见签名算法
	private String sign;
	public String getReturnCode() {
		return returnCode;
	}
	public void setReturnCode(String returnCode) {
		this.returnCode = returnCode;
	}
	public String getReturnMsg() {
		return returnMsg;
	}
	public void setReturnMsg(String returnMsg) {
		this.returnMsg = returnMsg;
	}
	public String getPayjsOrderId() {
		return payjsOrderId;
	}
	public void setPayjsOrderId(String payjsOrderId) {
		this.payjsOrderId = payjsOrderId;
	}
	public String getOutTradeNo() {
		return outTradeNo;
	}
	public void setOutTradeNo(String outTradeNo) {
		this.outTradeNo = outTradeNo;
	}
	public int getTotalFee() {
		return totalFee;
	}
	public void setTotalFee(int totalFee) {
		this.totalFee = totalFee;
	}
	public String getQrcode() {
		return qrcode;
	}
	public void setQrcode(String qrcode) {
		this.qrcode = qrcode;
	}
	public String getCodeUrl() {
		return codeUrl;
	}
	public void setCodeUrl(String codeUrl) {
		this.codeUrl = codeUrl;
	}
	public String getSign() {
		return sign;
	}
	public void setSign(String sign) {
		this.sign = sign;
	}	
	
	
}
