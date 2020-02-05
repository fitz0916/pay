
package com.github.trans.common.request;

import java.io.UnsupportedEncodingException;
import java.util.Base64;
import java.util.Base64.Decoder;
import java.util.Base64.Encoder;

import javax.validation.constraints.Pattern;

import org.apache.commons.lang3.StringUtils;
import org.hibernate.validator.constraints.NotBlank;

import com.github.trans.common.annotation.Signature;
import com.github.trans.common.constants.TransConstants;

public class PaymentRequest extends TransRequest{
	
	/** 加密数据(必选)加密数据，具体请见加密规则 **/
	@NotBlank(message = "signature不能为空")
	@Signature(required = false, desc = "加密签名")
	private String signature;
	
	/**后台回调地址**/
	@NotBlank(message = "notifyUrl不能为空")
	@Pattern(regexp = TransConstants.URL_REGEXP, message = "非法回调地址")
	private String notifyUrl;
	
	/**跳转页面地址**/
	@NotBlank(message = "returnUrl不能为空")
	@Pattern(regexp = TransConstants.URL_REGEXP, message = "非法页面转发地址")
	private String returnUrl;
	
	/**订单时间(可选)商户订单时间，格式：yyyyMMdd HH:mm:ss **/
	@NotBlank(message = "payTime不能为空")
	@Signature(required = true, desc = "交易时间")
	@Pattern(regexp = TransConstants.DATE_FORMAT_REGEXP,message = "时间格式不正确,格式为:yyyy-MM-dd HH:mm:ss")
	private String payTime;
	
	/** 商户该笔订单的总金额，以元为单位，精确到小数点后两位 **/
	@NotBlank(message = "orderTime不能为空")
	@Signature(required = true, desc = "交易时间")
	@Pattern(regexp = TransConstants.DECIMAL_REGEXP, message = "非法金额,请输入正整数,单位【元】,精确到小数点后两位")
	private String payAmount;
	
	/****币种,目前只有人民币-CNY**/
	@NotBlank(message = "currency不能为空")
	@Pattern(regexp = "(CNY{1})", message = "交易币种默认为:CNY")
	private String currency;
	
	/**交易类型,41-微信,42-支付宝,43-QQ钱包,52-网银银行,60-京东钱包,61-银联二维码,62-微信H5,63-QQH5**/
	@NotBlank(message = "payType不能为空")
	@Signature(required = true, desc = "交易类型,41-微信,42-支付宝,43-QQ钱包,52-网银银行,60-京东钱包,61-银联二维码,62-微信H5,63-QQH5")
	private String payType;
	
	/***主题***/
	@NotBlank(message = "subject不能为空")
	@Signature(required = true, desc = "主题")
	private String subject;
	/***描述***/
	@NotBlank(message = "desc不能为空")
	@Signature(required = true, desc = "描述")
	private String desc;
	
	/***扩展字段，JSON数据格式***/
	@NotBlank(message = "feature不能为空")
	@Signature(required = false, desc = "扩展字段")
	private String feature;
	
	
	public String getSignature() {
		return signature;
	}

	public void setSignature(String signature) {
		this.signature = signature;
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

	public String getPayTime() {
		return payTime;
	}

	public void setPayTime(String payTime) {
		this.payTime = payTime;
	}

	public String getPayAmount() {
		return payAmount;
	}

	public void setPayAmount(String payAmount) {
		this.payAmount = payAmount;
	}

	public String getCurrency() {
		return currency;
	}

	public void setCurrency(String currency) {
		this.currency = currency;
	}

	public String getPayType() {
		return payType;
	}

	public void setPayType(String payType) {
		this.payType = payType;
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

	public String getFeature() {
		return feature;
	}

	public void setFeature(String feature) {
		this.feature = feature;
	}

	/**
	 * 部分参数需要在签名前进行base64解码,不进行解码操作会出现验签失败
	 */
	public void base64Decoder() {
		Decoder base64Decoder = Base64.getDecoder();
		try {
			if(StringUtils.isNotBlank(subject)) {
				this.subject = new String(base64Decoder.decode(subject), "UTF-8");
			}
			if(StringUtils.isNotBlank(desc)) {
				this.desc = new String(base64Decoder.decode(desc), "UTF-8");
			}
		} catch (UnsupportedEncodingException e) {
			throw new IllegalArgumentException("参数解码错误");
//			e.printStackTrace();
		}
	}

	/**
	 * 部分参数需要在签名前进行base64编码,不进行编码操作会出现验签失败
	 */
	public void base64Encoder() {
		Encoder base64Encoder = Base64.getEncoder();
		try {
			if(StringUtils.isNotBlank(subject)) {
				this.subject = new String(base64Encoder.encode(subject.getBytes("utf-8")), "UTF-8");
			}
			if(StringUtils.isNotBlank(desc)) {
				this.desc = new String(base64Encoder.encode(desc.getBytes("utf-8")), "UTF-8");
			}
		} catch (UnsupportedEncodingException e) {
			throw new IllegalArgumentException("参数编码错误");
//			e.printStackTrace();
		}
	}
	
	
}
