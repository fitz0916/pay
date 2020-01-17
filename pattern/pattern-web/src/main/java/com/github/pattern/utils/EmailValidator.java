package com.github.pattern.utils;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.baidu.unbiz.fluentvalidator.ValidationError;
import com.baidu.unbiz.fluentvalidator.Validator;
import com.baidu.unbiz.fluentvalidator.ValidatorContext;
import com.baidu.unbiz.fluentvalidator.ValidatorHandler;

public class EmailValidator extends ValidatorHandler<String> implements Validator<String>{

private static final String EMAIL_REGEX  = "^\\w+((-\\w+)|(\\.\\w+))*\\@[A-Za-z0-9]+((\\.|-)[A-Za-z0-9]+)*\\.[A-Za-z0-9]+$";

	private String fieldName;

    public EmailValidator(String fieldName) {
        this.fieldName = fieldName;
    }

    @Override
    public boolean validate(ValidatorContext context, String s) {
    	Pattern pattern = Pattern.compile(EMAIL_REGEX);
    	Matcher matcher = pattern.matcher(s);
    	if(!matcher.find()) {
    		context.addError(ValidationError.create(String.format("%s格式不正确！", fieldName))
                    .setErrorCode(-1)
                    .setField(fieldName)
                    .setInvalidValue(s));
            return false;
    	}
        return true;
    }
    public static void main(String args[]) {
    	String phone = "xie_xieyu@sina.com";
    	Pattern pattern = Pattern.compile(EMAIL_REGEX);
    	Matcher matcher = pattern.matcher(phone);
    	if(matcher.find()) {
    		System.out.println("....");
    	}else {
    		System.out.println("222222");
    	}
    	
    }
}
