package com.github.admin.common.exception;

import org.apache.shiro.authc.AuthenticationException;

public class PermissionNotFoundException extends AuthenticationException{

	public PermissionNotFoundException() {
		
	}
	
	public PermissionNotFoundException(String msg) {
		super(msg);
	}
}
