package com.github.trans.server.service.pay;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.github.appmodel.domain.result.ModelResult;
import com.github.pattern.common.domain.Customer;
import com.github.pattern.common.domain.CustomerPaymentChannelInfo;
import com.github.trans.common.domain.PaymentOrder;
import com.github.trans.common.request.PaymentRequest;
import com.github.trans.common.response.PaymentQueryResponse;
import com.github.trans.common.response.PaymentResponse;
import com.github.trans.common.service.ThirdChannelService;
import com.github.trans.server.service.base.BaseThirdChannelService;

@Service
public class AliPayServiceImpl extends BaseThirdChannelService implements ThirdChannelService{
	
	private final static Logger LOGGER = LoggerFactory.getLogger(AliPayServiceImpl.class);
	
	
	@Override
	public ModelResult<PaymentResponse> pay(PaymentRequest request, Customer customer,CustomerPaymentChannelInfo customerPaymentChannelInfo) {
		LOGGER.info("支付宝扫码支付...........");
		ModelResult<PaymentResponse> modelResult = new ModelResult<PaymentResponse>();
		
		return modelResult;
	}


	@Override
	public ModelResult<PaymentQueryResponse> query(PaymentOrder paymentOrder,CustomerPaymentChannelInfo customerPaymentChannelInfo) {
		// TODO Auto-generated method stub
		return null;
	}

	

}
