package com.github.channel.web.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.github.appmodel.domain.result.ModelResult;
import com.github.channel.common.request.payjs.WechatPayRequest;
import com.github.channel.common.response.payjs.WechatPayResponse;
import com.github.channel.common.service.payjs.WechatPayService;

@RestController
@RequestMapping("/channel/server/wechatpay")
public class WechatPayController {
	
	@Autowired
	private WechatPayService<WechatPayRequest, WechatPayResponse> wechatPayServiceImpl;

	@PostMapping("/pay")
	public ModelResult<WechatPayResponse> pay(@RequestBody WechatPayRequest request){
		return wechatPayServiceImpl.pay(request);
		
	}
}
