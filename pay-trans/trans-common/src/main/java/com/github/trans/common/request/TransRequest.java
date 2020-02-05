package com.github.trans.common.request;

import java.io.Serializable;

import javax.validation.constraints.Pattern;

import org.apache.commons.lang3.builder.ReflectionToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import org.hibernate.validator.constraints.NotBlank;

import com.github.trans.common.annotation.Signature;
import com.github.trans.common.constants.TransConstants;

public  class TransRequest implements Serializable{

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
	
	private String sign;
	
	public String getSignMethod() {
		return signMethod;
	}



	public void setSignMethod(String signMethod) {
		this.signMethod = signMethod;
	}



	public String getPayOrderNo() {
		return payOrderNo;
	}



	public void setPayOrderNo(String payOrderNo) {
		this.payOrderNo = payOrderNo;
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



	public String getClientIp() {
		return clientIp;
	}



	public void setClientIp(String clientIp) {
		this.clientIp = clientIp;
	}



	public String getVersion() {
		return version;
	}



	public void setVersion(String version) {
		this.version = version;
	}



	public String getSign() {
		return sign;
	}



	public void setSign(String sign) {
		this.sign = sign;
	}



	@Override
	public String toString() {
		return ReflectionToStringBuilder.toString(this,ToStringStyle.MULTI_LINE_STYLE);
	}
	
}
