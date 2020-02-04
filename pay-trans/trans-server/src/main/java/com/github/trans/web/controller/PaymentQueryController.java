package com.github.trans.web.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.github.appmodel.domain.result.ModelResult;
import com.github.trans.common.request.PaymentQueryRequest;
import com.github.trans.common.response.PaymentQueryResponse;
import com.github.trans.common.service.PaymentQueryService;

@RestController
@RequestMapping("/trans/server/paymentquery")
public class PaymentQueryController {
	
	@Autowired
	private PaymentQueryService paymentQueryServiceImpl;

	@PostMapping("/query")
	public ModelResult<PaymentQueryResponse> query(@RequestBody PaymentQueryRequest request){
		return paymentQueryServiceImpl.query(request);
	}
}
