package com.github.admin.common.exception;

import org.apache.shiro.authc.AuthenticationException;

public class AccountLockException extends AuthenticationException{

	public AccountLockException() {
		
	}
	
	public AccountLockException(String msg) {
		super(msg);
	}
}
