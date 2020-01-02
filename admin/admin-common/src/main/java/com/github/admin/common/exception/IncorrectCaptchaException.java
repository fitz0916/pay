package com.github.admin.common.exception;

import org.apache.shiro.authc.AuthenticationException;

public class IncorrectCaptchaException extends AuthenticationException{
	
	public IncorrectCaptchaException() {
		
	}
	
	public IncorrectCaptchaException(String msg) {
		super(msg);
	}

}
