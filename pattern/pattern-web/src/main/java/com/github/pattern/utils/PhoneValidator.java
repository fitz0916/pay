package com.github.pattern.utils;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.baidu.unbiz.fluentvalidator.ValidationError;
import com.baidu.unbiz.fluentvalidator.Validator;
import com.baidu.unbiz.fluentvalidator.ValidatorContext;
import com.baidu.unbiz.fluentvalidator.ValidatorHandler;

public class PhoneValidator extends ValidatorHandler<String> implements Validator<String>{

	private static final String PHONE_REGEX = "^1([38][0-9]|4[579]|5[0-3,5-9]|6[6]|7[0135678]|9[89])\\d{8}$";
	
	private String fieldName;

    public PhoneValidator(String fieldName) {
        this.fieldName = fieldName;
    }

    @Override
    public boolean validate(ValidatorContext context, String s) {
    	Pattern pattern = Pattern.compile(PHONE_REGEX);
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
    	String phone = "15889385805";
    	Pattern pattern = Pattern.compile(PHONE_REGEX);
    	Matcher matcher = pattern.matcher(phone);
    	if(matcher.find()) {
    		System.out.println("....");
    	}
    	
    }
}
