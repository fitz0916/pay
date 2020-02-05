package com.github.trans.request;

import java.io.Serializable;

import javax.validation.constraints.Pattern;

import org.hibernate.validator.constraints.NotBlank;

import com.github.trans.annotation.Signature;
import com.github.trans.constants.TransConstants;

public class PaymentRequest implements Serializable{
	
	
	
	/**签名方式，MD5或者SHA256**/
	@NotBlank(message = "signMethod不能为空")
	@Pattern(message = "目前签名只有MD5", regexp = "(MD5{1})")
	@Signature(required = false, desc = "签名方式")
	private String signMethod;
	/**支付订单号**/
	@NotBlank(message = "payOrderNo不能为空")
	@Signature(required = true, desc = "交易订单号")
	private String payOrderNo;
	/**商户号***/
	@NotBlank(message = "customerNo不能为空")
	@Signature(required = true, desc = "商户号")
	@Pattern(regexp = "^[0-9]*$", message = "非法商户号,请输入正确的数字")
	private String customerNo;
	/**编码格式UTF-8**/
	@NotBlank(message = "inputCharset不能为空,编码格式为：UTF-8")
	@Pattern(message = "编码格式为：UTF-8", regexp = "(UTF-8{1})")
	@Signature(required = true, desc = "参数编码字符集,编码格式为：UTF-8")
	private String inputCharset;
	/**请求IP地址**/
	@NotBlank(message = "clientIp不能为空")
	@Pattern(regexp = TransConstants.IP_REGEXP,message = "请求IP格式不正确")
	@Signature(required = false, desc = "请求IP")
	private String clientIp;
	/***版本号**/
	@NotBlank(message = "version不能为空")
	@Pattern(message = "版本号格式为:1.0", regexp = "^[1]*(\\.[0]{1})?$")
	@Signature(required = true, desc = "接口版本")
	private String version;
	@NotBlank(message = "sign不能为空")
	private String sign;
	
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
	
	private String merKey;
	
	public String getSignMethod() {
		return signMethod;
	}
	public void setSignMethod(String signMethod) {
		this.signMethod = signMethod;
	}
	public String getSign() {
		return sign;
	}
	public void setSign(String sign) {
		this.sign = sign;
	}
	public String getSignature() {
		return signature;
	}
	public void setSignature(String signature) {
		this.signature = signature;
	}
	public String getCustomerNo() {
		return customerNo;
	}
	public void setCustomerNo(String customerNo) {
		this.customerNo = customerNo;
	}
	public String getInputCharset() {
		return inputCharset;
	}
	public void setInputCharset(String inputCharset) {
		this.inputCharset = inputCharset;
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
	public String getPayOrderNo() {
		return payOrderNo;
	}
	public void setPayOrderNo(String payOrderNo) {
		this.payOrderNo = payOrderNo;
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
	public String getVersion() {
		return version;
	}
	public void setVersion(String version) {
		this.version = version;
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
	public String getMerKey() {
		return merKey;
	}
	public void setMerKey(String merKey) {
		this.merKey = merKey;
	}
	
	
}
