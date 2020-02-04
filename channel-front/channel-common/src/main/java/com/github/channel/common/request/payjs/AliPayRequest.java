package com.github.channel.common.request.payjs;

import javax.validation.constraints.Pattern;

import org.hibernate.validator.constraints.NotBlank;

import com.github.channel.common.annotation.Signature;
import com.github.channel.common.constants.ChannelConstants;

public class AliPayRequest extends PayJsRequest{
	//支付宝交易传值：alipay ，微信支付无需此字段
	private String type = "alipay";
	//交易金额（分）
	@Pattern(regexp = ChannelConstants.DIGITAL_REGEXP, message = "totalFee[交易金额（分）]格式不正确")
	@Signature(required = true,desc = "交易金额")
	private String totalFee;
	//订单标题
	@NotBlank(message = "body[订单标题]不能为空")
	private String body;
	//用户自定义数据，在notify的时候会原样返回
	@NotBlank(message = "attach[用户自定义数据]不能为空")
	private String attach;
	//接收微信支付异步通知的回调地址。必须为可直接访问的URL，不能带参数、session验证、csrf验证。留空则不通知
	@NotBlank(message = "notifyUrl[异步通知的回调地址]不能为空")
	private String notifyUrl;
	public String getTotalFee() {
		return totalFee;
	}
	public void setTotalFee(String totalFee) {
		this.totalFee = totalFee;
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
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
}
