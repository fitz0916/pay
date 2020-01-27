package com.github.trans.common.service;

import com.github.appmodel.domain.result.ModelResult;
import com.github.trans.common.request.PaymentRequest;
import com.github.trans.common.response.PaymentResponse;

public interface PaymentService{
	
	/****
	 *  支付接口
	 * @param paymentRequest
	 * @return
	 */
	public ModelResult<PaymentResponse> pay(PaymentRequest paymentRequest);
	
	
	
}
