package com.github.channel.web.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.github.appmodel.domain.result.ModelResult;
import com.github.channel.common.request.WechatPayRequest;
import com.github.channel.common.response.WechatPayResponse;
import com.github.channel.common.service.PayJsService;

@RestController
@RequestMapping("/channel/server/wechatpay")
public class WechatPayController {
	
	@Autowired
	private PayJsService<WechatPayRequest, WechatPayResponse> wechatPayServiceImpl;

	@PostMapping("/pay")
	public ModelResult<WechatPayResponse> pay(@RequestBody WechatPayRequest request){
		return wechatPayServiceImpl.pay(request);
		
	}
}
