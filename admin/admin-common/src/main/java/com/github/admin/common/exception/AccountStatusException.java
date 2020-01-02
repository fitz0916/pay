package com.github.admin.common.exception;

import org.apache.shiro.authc.AuthenticationException;

public class AccountStatusException extends AuthenticationException{

	public AccountStatusException() {
		
	}
	
	public AccountStatusException(String msg) {
		super(msg);
	}
}
