package com.github.trans.common.annotation;

import java.lang.annotation.Documented;
import java.lang.annotation.ElementType;
import java.lang.annotation.Inherited;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Target(ElementType.TYPE)
@Retention(RetentionPolicy.RUNTIME)
@Inherited
@Documented
public @interface PaymentStrategy {
	
	 //支付类型
	 String payType() default "";
	 //渠道描述
	 String templateName() default "";
	
	 String desc() default "";
	
	
	

}
