package com.github.appmodel.vo;

import com.github.appmodel.base.BaseObject;

public class ResultVo extends BaseObject{

	
	/**
	 * 
	 */
	private static final long serialVersionUID = -7638634174347794880L;
	private boolean isSuccess;
	private String code;
	private String msg;
	public Object data;
	
	
	public Object getData() {
		return data;
	}
	public void setData(Object data) {
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
	
}
