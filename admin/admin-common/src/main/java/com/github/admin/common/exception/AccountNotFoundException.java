package com.github.admin.common.exception;

import org.apache.shiro.authc.AuthenticationException;

public class AccountNotFoundException extends AuthenticationException{

	public AccountNotFoundException() {
		
	}
	
	public AccountNotFoundException(String msg) {
		super(msg);
	}
	
}
