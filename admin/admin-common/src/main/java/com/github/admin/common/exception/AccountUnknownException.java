package com.github.admin.common.exception;

import org.apache.shiro.authc.AuthenticationException;

public class AccountUnknownException extends AuthenticationException{

	public AccountUnknownException() {
	}
	
	public AccountUnknownException(String msg) {
		super(msg);
	}
}
