package com.github.trans.exception;

public class PaymentException extends RuntimeException{

	/**
	 * 
	 */
	private static final long serialVersionUID = -7277083036754333556L;
	
	/**错误码**/
	private String code;
	/**错误描述**/
	private String msg;
	
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

	public PaymentException(String message) {
		super(message);
	}

	public PaymentException(String message, Throwable cause) {
		super(message, cause);
	}
	
	public PaymentException(String code,String message) {
		super(message);
		this.setCode(code);
	}
	
}
