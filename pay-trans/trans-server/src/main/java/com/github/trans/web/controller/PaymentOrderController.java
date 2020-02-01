package com.github.trans.web.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.github.appmodel.domain.result.ModelResult;
import com.github.appmodel.vo.PageVo;
import com.github.trans.common.request.PaymentOrderRequest;
import com.github.trans.common.service.PaymentOrderService;

@RestController
@RequestMapping("/trans/server/paymentorder")
public class PaymentOrderController {
	
	
	@Autowired
	private PaymentOrderService paymentOrderServiceImpl;
	
	@PostMapping("/page")
	ModelResult<PageVo> page(@RequestBody PaymentOrderRequest request){
		return paymentOrderServiceImpl.page(request);
	}

}
