package com.github.channel.web.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.github.appmodel.domain.result.ModelResult;
import com.github.channel.common.request.payjs.WechatPayQueryRequest;
import com.github.channel.common.response.payjs.WechatPayQueryResponse;
import com.github.channel.common.service.payjs.WechatPayQueryService;

@RestController
@RequestMapping("/channel/server/wechatpayquery")
public class WechatPayQueryController {
	
	@Autowired
	private WechatPayQueryService<WechatPayQueryRequest, WechatPayQueryResponse> wechatPayQueryServiceImpl;

	@PostMapping("/query")
	public ModelResult<WechatPayQueryResponse> query(@RequestBody WechatPayQueryRequest request){
		return wechatPayQueryServiceImpl.query(request);
	}
}
