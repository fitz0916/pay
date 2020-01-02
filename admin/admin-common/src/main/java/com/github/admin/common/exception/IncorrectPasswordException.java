package com.github.admin.common.exception;

import org.apache.shiro.authc.AuthenticationException;

public class IncorrectPasswordException extends AuthenticationException{

	public IncorrectPasswordException() {
		
	}
	
	public IncorrectPasswordException(String msg) {
		super(msg);
	}
	
}
