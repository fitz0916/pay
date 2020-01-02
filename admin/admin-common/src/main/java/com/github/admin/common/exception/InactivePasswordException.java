package com.github.admin.common.exception;

import org.apache.shiro.authc.AuthenticationException;

public class InactivePasswordException extends AuthenticationException{

	public InactivePasswordException() {
		
	}
	
	public InactivePasswordException(String msg) {
		super(msg);
	}
}
