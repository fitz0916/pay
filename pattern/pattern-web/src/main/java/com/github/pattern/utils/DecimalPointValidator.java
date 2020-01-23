package com.github.pattern.utils;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.baidu.unbiz.fluentvalidator.ValidationError;
import com.baidu.unbiz.fluentvalidator.Validator;
import com.baidu.unbiz.fluentvalidator.ValidatorContext;
import com.baidu.unbiz.fluentvalidator.ValidatorHandler;

public class DecimalPointValidator extends ValidatorHandler<String> implements Validator<String>{	
											  //^(([^0][0-9]+|0)\.([0-9]{1,4}))$
	private static final String DECIMAL_POINT_REGEX  = "^(([^0][0-9]+|0)\\.([0-9]{2,4}))$";

	private String fieldName;

    public DecimalPointValidator(String fieldName) {
        this.fieldName = fieldName;
    }

    @Override
    public boolean validate(ValidatorContext context, String s) {
    	Pattern pattern = Pattern.compile(DECIMAL_POINT_REGEX);
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
    
}
