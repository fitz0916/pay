package com.github.trans.server.service.pay;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.github.appmodel.domain.result.ModelResult;
import com.github.pattern.common.domain.Customer;
import com.github.pattern.common.domain.CustomerPaymentChannelInfo;
import com.github.trans.common.request.PaymentRequest;
import com.github.trans.common.response.PaymentResponse;
import com.github.trans.common.service.ThirdChannelService;

@Service
public class WechatPayServiceImpl extends BaseThirdChannelService implements ThirdChannelService{
	
	private final static Logger LOGGER = LoggerFactory.getLogger(WechatPayServiceImpl.class);
	
	@Override
	public ModelResult<PaymentResponse> process(PaymentRequest request, Customer customer,CustomerPaymentChannelInfo customerPaymentChannelInfo) {
		LOGGER.info("微信扫码支付.............");
		ModelResult<PaymentResponse> modelResult = new ModelResult<PaymentResponse>();
		
		return modelResult;
	}

	

}
