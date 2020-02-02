package com.github.trans.client;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.github.appmodel.domain.result.ModelResult;
import com.github.trans.common.request.PaymentRequest;
import com.github.trans.common.response.PaymentResponse;

@FeignClient(name="trans-server")
@RequestMapping("/trans/server/payment")
public interface PaymentServiceClient {

	@PostMapping("/pay")
	public ModelResult<PaymentResponse> pay(@RequestBody PaymentRequest request);
}
