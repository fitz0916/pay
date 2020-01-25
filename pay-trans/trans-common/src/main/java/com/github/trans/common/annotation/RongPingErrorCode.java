package com.github.trans.common.annotation;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.github.trans.common.exception.PaymentException;

/**
 * 爱农应答码
 */
public enum RongPingErrorCode {

    PARSE_RESPONSE_EXCEPTION("59007", "解析返回结果错误"),

    PERMISSION_NOT_ENOUTH("-102","权限不足"),
    INVALID_SIGNATURE("-100","无效签名"),
    INVALID_PARAMS("-101","无效参数"),
    SERVER_EROOR("-200","服务器异常"),
    NORMAL_ERROR("-103","通用错误"),
    USER_IN_PAYMENT("100","用户正在支付中"),
    ;

    private static Logger logger = LoggerFactory.getLogger(RongPingErrorCode.class);

    private String code;

    private String message;

    RongPingErrorCode(String code, String message) {
        this.code = code;
        this.message = message;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public PaymentException exe(RongPingErrorCode rongPingErrorCode){
        logger.error("对接第三方支付错误码code:【{}】,错误描述errMsg:【{}】",rongPingErrorCode.code,rongPingErrorCode.message);
        return new PaymentException(rongPingErrorCode.getCode(),rongPingErrorCode.getMessage());
    }


    public static RongPingErrorCode findByCode(String code){
        for(RongPingErrorCode errorCode:RongPingErrorCode.values()){
            if(errorCode.getCode().equals(code)){
                return errorCode;
            }
        }
        return null;
    }
}
