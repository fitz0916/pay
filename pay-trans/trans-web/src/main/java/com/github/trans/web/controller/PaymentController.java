package com.github.trans.web.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.github.appmodel.domain.result.ResultUtils;
import com.github.trans.client.PaymentServiceClient;
import com.github.trans.common.request.PaymentRequest;
import com.github.trans.utils.RequestUtil;

@RestController
@RequestMapping("/brokenes")
public class PaymentController {

	@Autowired
	private PaymentServiceClient paymentServiceClient;
	
	@PostMapping("/pay")
	public Object pay(PaymentRequest paymentRequest,HttpServletRequest request) {
		String clientRealIp = RequestUtil.getIpAddr(request);
		paymentRequest.setClientIp(clientRealIp);
		return ResultUtils.buildResult(paymentServiceClient.pay(paymentRequest));
	}
	
}
