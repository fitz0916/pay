package com.github.admin.common.vo;

import java.io.Serializable;

public class ResultVo implements Serializable{
	
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -8214371334790382733L;
	
	public ResultVo() {
		
	}
	
	public ResultVo(String code,String msg) {
		this.code = code;
		this.msg = msg;
	}
	
	public Object data;
	private boolean isSuccess;
	private String code;
	private String msg;
	
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
