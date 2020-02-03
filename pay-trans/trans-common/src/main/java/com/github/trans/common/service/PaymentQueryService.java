package com.github.trans.common.service;

import com.github.appmodel.domain.result.ModelResult;
import com.github.trans.common.request.PaymentQueryRequest;
import com.github.trans.common.response.PaymentQueryResponse;

public interface PaymentQueryService {

	public ModelResult<PaymentQueryResponse> queryOrder(PaymentQueryRequest request);
}
