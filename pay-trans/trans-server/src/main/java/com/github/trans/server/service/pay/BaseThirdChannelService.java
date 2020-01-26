package com.github.trans.server.service.pay;

import javax.annotation.PostConstruct;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.github.trans.common.annotation.PaymentStrategy;

public abstract class BaseThirdChannelService {

	private final static Logger LOGGER = LoggerFactory.getLogger(BaseThirdChannelService.class);
	
	
//	@PostConstruct
//	protected void initPaymentChannelTemplate() {
//		Class<?> clazz = this.getClass();
//		PaymentStrategy paymentStrategys[] = clazz.getDeclaredAnnotationsByType(PaymentStrategy.class);
//		LOGGER.warn("******************* 三方支付渠道数为:【{}】*******************",paymentStrategys.length);
//		for(PaymentStrategy paymentStrategy:paymentStrategys) {
//			String payType = paymentStrategy.payType();
//			String templateName = paymentStrategy.templateName();
//			String desc = paymentStrategy.desc();
//		}
//		
//	}
}
