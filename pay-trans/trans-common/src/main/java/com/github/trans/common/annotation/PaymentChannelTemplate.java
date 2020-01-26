package com.github.trans.common.annotation;

public enum PaymentChannelTemplate {

	
	ALIPAY_CHANNEL_TEMPLATE("2","支付宝扫码支付",AliPayServiceImpl.class);
	
	private String tradeType;
	
	private String templateName;
	
	private Class<?> clazz;
	
	
	 PaymentChannelTemplate(String tradeType,String templateName,Class<?> clazz){
		this.tradeType = tradeType;
		this.templateName = templateName;
		this.clazz = clazz;
	}
	
	
	
}
