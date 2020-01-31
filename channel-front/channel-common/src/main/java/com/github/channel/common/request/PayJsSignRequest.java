package com.github.channel.common.request;

import com.github.channel.common.domain.BaseObject;

public class PayJsSignRequest extends BaseObject{
	
	private String outTradeNo;
	private String mchid;
	private String totalFee;
	
	public String getOutTradeNo() {
		return outTradeNo;
	}
	public void setOutTradeNo(String outTradeNo) {
		this.outTradeNo = outTradeNo;
	}
	public String getMchid() {
		return mchid;
	}
	public void setMchid(String mchid) {
		this.mchid = mchid;
	}
	public String getTotalFee() {
		return totalFee;
	}
	public void setTotalFee(String totalFee) {
		this.totalFee = totalFee;
	}
	
	

}
