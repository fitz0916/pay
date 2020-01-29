package com.github.trans.server.service.pay;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.github.appmodel.domain.result.ModelResult;
import com.github.pattern.client.service.CustomerPaymentChannelFeeServiceClient;
import com.github.pattern.common.domain.CustomerPaymentChannelFee;

public abstract class BaseThirdChannelService {

	private final static Logger LOGGER = LoggerFactory.getLogger(BaseThirdChannelService.class);
	
	@Autowired
	private CustomerPaymentChannelFeeServiceClient customerPaymentChannelFeeServiceClient;
	
	
	protected ModelResult<CustomerPaymentChannelFee> initFee(Integer customerId,Integer paymentChannelId){
		ModelResult<CustomerPaymentChannelFee>  modelResult = customerPaymentChannelFeeServiceClient.selectByCustomerIdAndPaymentChannelId(customerId, paymentChannelId);
		if(!modelResult.isSuccess() || modelResult.getModel() == null || modelResult.getModel().getStatus() == 0) {
			String errorCode = modelResult.getErrorCode() == null ? "0" : modelResult.getErrorCode();
			String errorMsg = modelResult.getErrorMsg() == null ? "商户费率未设置" : modelResult.getErrorMsg();
			LOGGER.warn("customerId = 【{}】,paymentChannelId = 【{}】商户费率没有设置",customerId,paymentChannelId);
			modelResult.withError(errorCode, errorMsg);
			return modelResult;
		}
		return modelResult;
	}

}
