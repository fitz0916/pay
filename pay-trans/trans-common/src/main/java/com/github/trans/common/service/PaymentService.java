package com.github.trans.common.service;

import com.github.appmodel.domain.result.ModelResult;
import com.github.trans.common.request.TransRequest;
import com.github.trans.common.response.TransResponse;

public interface PaymentService<Q extends TransRequest,P extends TransResponse> {
	
	/****
	 *  支付接口
	 * @param paymentRequest
	 * @return
	 */
	public ModelResult<P> pay(Q paymentRequest);
	
	
	
}
