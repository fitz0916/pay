package com.github.trans.common.utils;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import javax.validation.ConstraintViolation;
import javax.validation.Validation;
import javax.validation.Validator;
import javax.validation.ValidatorFactory;

import com.github.trans.common.request.PaymentRequest;

public class BeanValidatorUtils {

	//校验工厂
    private static ValidatorFactory validatorFactory = Validation.buildDefaultValidatorFactory();
    
    public static List<String> validateParam(Object o) {
		List<String> messageList=new ArrayList<>();
		Validator validation = validatorFactory.getValidator();
		Set<ConstraintViolation<Object>> set = validation.validate(o);
		set.stream().forEach(result->{
			messageList.add(result.getMessage());
		});
		return messageList;
	}
    
    /**
	 * IP地址有效性校验
	 * @param ip
	 * @return
	 */
	public static boolean checkIP(String ip) {
        if (ip != null && !ip.isEmpty()) {
            // 定义正则表达式
            String regex = "^(1\\d{2}|2[0-4]\\d|25[0-5]|[1-9]\\d|[1-9])\\."
                      +"(1\\d{2}|2[0-4]\\d|25[0-5]|[1-9]\\d|\\d)\\."
                      +"(1\\d{2}|2[0-4]\\d|25[0-5]|[1-9]\\d|\\d)\\."
                      +"(1\\d{2}|2[0-4]\\d|25[0-5]|[1-9]\\d|\\d)$";
            // 判断ip地址是否与正则表达式匹配
            if (ip.matches(regex)) {
                // 返回判断信息
                return true;
            } else {
                // 返回判断信息
                return false;
            }
        }
        return false;
	}
	
	
}
