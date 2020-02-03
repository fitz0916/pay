package com.github.trans.common.service;

import com.github.appmodel.domain.result.ModelResult;
import com.github.pattern.common.domain.Customer;
import com.github.pattern.common.domain.CustomerPaymentChannelInfo;
import com.github.trans.common.domain.PaymentOrder;
import com.github.trans.common.request.PaymentRequest;
import com.github.trans.common.response.PaymentQueryResponse;
import com.github.trans.common.response.PaymentResponse;

public interface ThirdChannelService {

	/***
	 * 对接银行前置接口，抽象为策略模式
	 * @param q
	 * @param customer
	 * @return
	 */
	public ModelResult<PaymentResponse> pay(PaymentRequest request,Customer customer,CustomerPaymentChannelInfo customerPaymentChannelInfo);
	
	
	public ModelResult<PaymentQueryResponse> query(PaymentOrder paymentOrder);
}
