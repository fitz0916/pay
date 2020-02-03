package com.github.trans.server.service;

import com.github.appmodel.domain.result.ModelResult;
import com.github.pattern.common.domain.Customer;
import com.github.trans.common.request.PaymentQueryRequest;
import com.github.trans.common.response.PaymentQueryResponse;
import com.github.trans.common.service.PaymentQueryService;
import com.github.trans.server.service.base.BasePaymentService;

public class PaymentQueryServiceImpl extends BasePaymentService<PaymentQueryRequest, PaymentQueryResponse> implements PaymentQueryService{

	@Override
	public ModelResult<PaymentQueryResponse> queryOrder(PaymentQueryRequest request) {
		 ModelResult<PaymentQueryResponse> modelResult = new  ModelResult<PaymentQueryResponse>();
	 		//参数检测
			modelResult = this.checkRequestParamter(request);
			if(!modelResult.isSuccess()) {
				return modelResult;
			}
			ModelResult<Customer> customerModelResult = this.checkPaymentStatus(request);
			if(!customerModelResult.isSuccess()) {
				String errorCode = customerModelResult.getErrorCode();
				String errorMsg = customerModelResult.getErrorMsg();
				modelResult.withError(errorCode, errorMsg);
				return modelResult;
			}
			Customer customer = customerModelResult.getModel();
			//签名检测
			modelResult = this.checkRequestSign(request,customer);
			if(!modelResult.isSuccess()) {
				return modelResult;
			}
		return modelResult;
	}

}
