package com.github.trans.client;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.github.appmodel.domain.result.ModelResult;
import com.github.appmodel.vo.PageVo;
import com.github.trans.common.request.PaymentOrderRequest;

@FeignClient(name="trans-server")
@RequestMapping("/trans/server/paymentorder")
public interface PaymentOrderServiceClient {

	@PostMapping("/page")
	ModelResult<PageVo> page(@RequestBody PaymentOrderRequest request);
}
