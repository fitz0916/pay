package com.github.channel.client.service.payjs;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.github.appmodel.domain.result.ModelResult;
import com.github.channel.common.request.payjs.WechatPayRequest;
import com.github.channel.common.response.payjs.WechatPayResponse;

@FeignClient(name="channel-server")
@RequestMapping("/channel/server/wechatpay")
public interface WechatPayServiceClient {

	
	@PostMapping("/pay")
	public ModelResult<WechatPayResponse> pay(@RequestBody WechatPayRequest request);
}
