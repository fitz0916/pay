package com.github.trans.common.annotation;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.github.trans.common.exception.PaymentException;

/**
 * 错误枚举
 * 跨度：59000-59999
 *
 */
public enum PaymentErrorCode {


	PARAM_NOT_NULL("59000", "参数[%s], 不能为空"),
	PARAM_ERROR("59001", "参数[%s], %s"),
	PAYMENT_ERROR("59002", "代付异常"),
	PAYMENT_REPEAT("59003", "代付异常,重复代付"),
	PAYMENT_TIMEOUT("59004", "代付异常,代付请求响应超时"),
	PAYMENT_AMOUNT_NOTVALID("59005", "代付金额异常小于1分"),
	PAYMENT_AMOUNT_BEYOND("59006", "代付异常,金额超出通道限额"),
	SEND_BANK_BEFORE_EXCEPTION("59007", "发送银行指令前，程序异常"),
	QUERY_ERROR("59008", "查询异常"),
	QUERY_NOPAYMENT("59009", "查询异常,无对应的代付信息"),
	DATA_SERVICE_ERROR("59010", "数据服务异常[%s], %s"),
	CHANNEL_NOTFOUND("59011", "暂不支持此渠道"),
	UNKNOW_ERROR("59012", "未知错误"),
	RECON_ERROR("59013", "对账异常,[%s]"),
	RECON_NOCOUNT("59014", "对账异常,没有对应的汇总信息"),
	ACCOUNT_BAL_QUERY_ERROR("59015", "账户余额查询异常,[%s]"),
	ACCOUNT_BAL_QUERY_NORECORD("59016", "账户余额查询查询异常,无对应的账户信息"),
	PRE_DATE_TIME_IS_NULL("59017", "预约交易时候,必须参数预约日期或者时间为空"),
	REC_BANK_NAME_OR_BANK_CODE_LEAST_ONE_VALUE("59018", "收款方账号开户行和收款账户开户联行网点号至少一项有值"),
	OUT_BANK_SINGLE_PAY_STATUS_NORECORD("59019", "银联跨行代付单笔状态查询异常,无对应的代付信息"),
	CURRENCY_NOT_SUPPORT("59020", "此业务暂时不支持[%s]币种"),
	ACCOUNT_INFO_QUERY_ERROR("59021", "账户明细信息查询异常,[%s]"),
	ACCOUNT_INFO_QUERY_NORECORD("59022", "账户明细信息查询异常,无对应的账户信息"),
	SUB_ACCOUNT_TRANS_DETAIL_QUERY("59023", "附属账户交易明细查询异常"),
	SIGNATURE_ERROR("59024", "签名错误"),
	TRACTOR_TRANSFER("59025", "转账记录重复：[%s]"),
	CEBB_IDENTI_NUM_IS_ERROR("59026", "身份证号码格式不正确"),
	CEBB_APPLY_SECRETKEY_IS_ERROR("59027", "申请工作密钥出错"),
	SPDB_TRANSACTION_RECORD_NOT_EXIST_ERROR("59028", "该笔交易记录不存在"),
	PHONE_NUM_IS_ERROR("59029", "手机号码不正确"),
	SYSTEM_ERROR("59030","服务器繁忙，请稍后重试"),

	RETURN_CODE_NULL("59031","返回code为空"),
	RESPONSE_IS_NULL("59032","请求响应内容为空"),
	REQUEST_PARAM_NULL("59034","请求参数为空"),
	RETURN_XML_ERROR("59035","解析返回结果XML出错"),
	RETURN_SIGNATURE_NULL("59036","返回签名为空"),
	VERIFY_SIGNATURE_ERROR("59037","验签失败"),
	DECODE_ERROR("59038","转码错误"),
	EXCEPTION_FAIL("59039","异常失败"),
	BUESSINE_FAIL("59040","业务失败"),
	REQUEST_ABORTED("59041","请求失败"),
	UNKNOW_CODE("59042","请求失败"),
	SIGN_ERROR("59043","证书签名失败"),
	CALLBACK_EXCEPTION("59044","回调异常"),




	USER_IN_PAYMENT("59066","用户支付中"),

	;

	private static Logger logger = LoggerFactory.getLogger(PaymentErrorCode.class);

	private String code;

	private String message;

	private PaymentErrorCode(String code) {
		this.code = code;
	}

	private PaymentErrorCode(String code, String message) {
		this.code = code;
		this.message = message;
	}

	/**
	 * @return the code
	 */
	public String getCode() {
		return code;
	}

	/**
	 * @return the message
	 */
	public String getMessage() {
		return message;
	}

	/**
	 * 采用枚举中定义的message作为异常的信息
	 *
	 * @return
	 */
	public PaymentException exp() {
		return new PaymentException(code, message);
	}

	/**
	 * 采用枚举中定义的message作为异常信息，并传递一些参数
	 *
	 * @param args
	 * @return
	 */
	public PaymentException exp(Object... args) {
		String formatReason = String.format(message, args);
		return new PaymentException(code, formatReason);
	}

	/**
	 * 采用枚举中定义的code，使用自定义的message作为异常信息，并可能会带上一些参数
	 *
	 * @param message
	 * @param args
	 * @return
	 */
	public PaymentException expMsg(String message, Object... args) {
		String formatReason = String.format(message, args);
		return new PaymentException(code, formatReason);
	}

	public PaymentException exe(PaymentErrorCode paymentErrorCode){
		logger.error("对接第三方支付错误码code:【{}】,错误描述errMsg:【{}】",paymentErrorCode.code,paymentErrorCode.message);
		return new PaymentException(paymentErrorCode.getCode(),paymentErrorCode.getMessage());
	}


	public static PaymentErrorCode findByCode(String code){
		for(PaymentErrorCode errorCode:PaymentErrorCode.values()){
			if(errorCode.getCode().equals(code)){
				return errorCode;
			}
		}
		return null;
	}
}
