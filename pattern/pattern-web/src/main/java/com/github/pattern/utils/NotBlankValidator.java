package com.github.pattern.utils;

import com.baidu.unbiz.fluentvalidator.ValidationError;
import com.baidu.unbiz.fluentvalidator.Validator;
import com.baidu.unbiz.fluentvalidator.ValidatorContext;
import com.baidu.unbiz.fluentvalidator.ValidatorHandler;

public class NotBlankValidator extends ValidatorHandler<String> implements Validator<String>{

	private String fieldName;

    public NotBlankValidator(String fieldName) {
        this.fieldName = fieldName;
    }

    @Override
    public boolean validate(ValidatorContext context, String s) {
        if (null == s || s.trim().equals("") || s.length() != s.trim().length()) {
            context.addError(ValidationError.create(String.format("%s不能为空且不能包含空格！", fieldName))
                    .setErrorCode(-1)
                    .setField(fieldName)
                    .setInvalidValue(s));
            return false;
        }
        
        return true;
    }
}
