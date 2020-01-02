package com.github.admin.common.exception;

import org.apache.shiro.authc.AuthenticationException;

public class RoleNotFoundException extends AuthenticationException{

	public RoleNotFoundException() {
		
	}
	
	public RoleNotFoundException(String msg) {
		super(msg);
	}
}
