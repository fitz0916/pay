package com.github.channel.common.request.payjs;

import javax.validation.constraints.Pattern;

import org.hibernate.validator.constraints.NotBlank;

import com.github.channel.common.annotation.Signature;
import com.github.channel.common.constants.ChannelConstants;
import com.github.channel.common.domain.ChannelRequest;

public class PayJsRequest extends ChannelRequest{

	//商户号
	@NotBlank(message = "mchid[商户号]不能为空")
	@Signature(required = true,desc = "[商户号]不能为空")
	private String mchid;
	//请求地址
	@NotBlank(message = "url[请求渠道]不能为空")
	@Pattern(regexp = ChannelConstants.URL_REGEXP, message = "请求渠道地址")
	private String url;
	//秘钥
	private String secretKey;
	//用户端自主生成的订单号
	@NotBlank(message = "outTradeNo[订单号]不能为空")
	@Signature(required = true,desc = "订单号")
	private String outTradeNo;
	//数据签名
	private String sign;
	
	public String getMchid() {
		return mchid;
	}
	public void setMchid(String mchid) {
		this.mchid = mchid;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getSecretKey() {
		return secretKey;
	}
	public void setSecretKey(String secretKey) {
		this.secretKey = secretKey;
	}
	public String getOutTradeNo() {
		return outTradeNo;
	}
	public void setOutTradeNo(String outTradeNo) {
		this.outTradeNo = outTradeNo;
	}
	public String getSign() {
		return sign;
	}
	public void setSign(String sign) {
		this.sign = sign;
	}
	
	
}
