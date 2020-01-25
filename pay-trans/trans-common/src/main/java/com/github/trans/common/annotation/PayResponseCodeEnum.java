package com.github.trans.common.annotation;

/**
 * 支付API返回状态码
 *
 */
public enum PayResponseCodeEnum {
	SUCCESS("2000","成功"),
	SYSTEM_MAINTAIN("1003","系统维护中"),
	QRCODE_MAINTAIN("1004","二维码功能维护中"),
	PARAM_NOTEMPTY("3000","参数不能为空"),
	SHOP_NOTEXIST("3001","门店不存在"),
	TRADETYPE_ERROR("3002","tradeType错误"),
	UNASSIGNED_PAYCHANNEL("3003","未分配收款通道或者错误"),
	AMOUNT_PAYMENT_EXCEEDS_SINGLE_LIMIT("3004","支付通道不存在或者已超限额"),
	AGENT_NOTEXIST("3005","商户不存在"),
	CHECK_SIGN_FAILURE("3006","验签失败"),
	ORDER_SUBMIT_FAILURE("3007","订单无法添加，申请失败"),
	SUBMIT_METHOD_FAILURE("3008","提交方式错误"),
	CHANNEL_NOTEXIST("3009","通道不存在,或通道未开通该支付类型"),
	AMOUNT_ERROR("3011","每次金额不能低于十元"),
	OTHER_ERROR("4002","其他错误");
	
	private String code;
	private String msg;
	
	PayResponseCodeEnum(String code,String msg) {
		this.code = code;
		this.msg = msg;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}
	
	
	public static PayResponseCodeEnum findByCode(String code) {
		for(PayResponseCodeEnum paymentCode:PayResponseCodeEnum.values()) {
			if(paymentCode.getCode().equals(code)) {
				return paymentCode;
			}
		}
		return null;
	}
	
	
}
