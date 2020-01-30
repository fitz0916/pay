package com.github.channel.common.request;

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
	//交易金额（分）
	@Pattern(regexp = ChannelConstants.DIGITAL_REGEXP, message = "totalFee[交易金额（分）]格式不正确")
	@Signature(required = true,desc = "交易金额")
	private String totalFee;
	//用户端自主生成的订单号
	@NotBlank(message = "outTradeNo[订单号]不能为空")
	@Signature(required = true,desc = "订单号")
	private String outTradeNo;
	//订单标题
	private String body;
	//用户自定义数据，在notify的时候会原样返回
	private String attach;
	//接收微信支付异步通知的回调地址。必须为可直接访问的URL，不能带参数、session验证、csrf验证。留空则不通知
	private String notifyUrl;
	//数据签名
	private String sign;
	//请求地址
	@NotBlank(message = "url[请求地址]不能为空")
	@Pattern(regexp = ChannelConstants.URL_REGEXP, message = "非法回调地址")
	private String url;
	//秘钥
	private String secretKey;
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
	public String getOutTradeNo() {
		return outTradeNo;
	}
	public void setOutTradeNo(String outTradeNo) {
		this.outTradeNo = outTradeNo;
	}
	public String getBody() {
		return body;
	}
	public void setBody(String body) {
		this.body = body;
	}
	public String getAttach() {
		return attach;
	}
	public void setAttach(String attach) {
		this.attach = attach;
	}
	public String getNotifyUrl() {
		return notifyUrl;
	}
	public void setNotifyUrl(String notifyUrl) {
		this.notifyUrl = notifyUrl;
	}
	public String getSign() {
		return sign;
	}
	public void setSign(String sign) {
		this.sign = sign;
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
	
	
}
