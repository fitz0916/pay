package com.github.admin.common.exception;


public class SessionTimeOutException extends RuntimeException {
    public SessionTimeOutException() {

    }

    public SessionTimeOutException(String msg) {
        super(msg);
    }
}
