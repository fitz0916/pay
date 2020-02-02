package com.github.trans.web.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.github.appmodel.domain.result.ModelResult;
import com.github.trans.common.request.PaymentRequest;
import com.github.trans.common.response.PaymentResponse;
import com.github.trans.common.service.PaymentService;

@RestController
@RequestMapping("/trans/server/payment")
public class PaymentController {
	
	@Autowired
	private PaymentService paymentServiceImpl;
	
	@PostMapping("/pay")
	public ModelResult<PaymentResponse> pay(@RequestBody PaymentRequest request){
		return paymentServiceImpl.pay(request);
	}

}
