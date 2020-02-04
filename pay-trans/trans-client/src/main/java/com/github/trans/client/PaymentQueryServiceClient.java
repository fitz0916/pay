package com.github.trans.client;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.github.appmodel.domain.result.ModelResult;
import com.github.trans.common.request.PaymentQueryRequest;
import com.github.trans.common.response.PaymentQueryResponse;

@FeignClient(name="trans-server")
@RequestMapping("/trans/server/paymentquery")
public interface PaymentQueryServiceClient {

	@PostMapping("/query")
	public ModelResult<PaymentQueryResponse> query(@RequestBody PaymentQueryRequest request);
}
