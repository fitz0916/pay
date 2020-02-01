package com.github.appmodel.vo;

import com.github.appmodel.base.BaseObject;

public class ErrorMsgVo extends BaseObject{

	private boolean isSuccess;
	private String code;
	private String msg;
	private Object data;
	
	
	public ErrorMsgVo() {
		
	}
	
	public ErrorMsgVo(String code, Object data) {
		this.code = code;
		this.data = data;
	}
	
	public ErrorMsgVo(String code, String msg, Object data) {
		this.code = code;
		this.msg = msg;
		this.data = data;
	}
	
	
	public boolean isSuccess() {
		return isSuccess;
	}

	public void setSuccess(boolean isSuccess) {
		this.isSuccess = isSuccess;
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
	public Object getData() {
		return data;
	}
	public void setData(Object data) {
		this.data = data;
	}
}
