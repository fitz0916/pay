package com.github.channel.client.service.payjs;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.github.appmodel.domain.result.ModelResult;
import com.github.channel.common.request.payjs.WechatPayQueryRequest;
import com.github.channel.common.response.payjs.WechatPayQueryResponse;

@FeignClient(name="channel-server")
@RequestMapping("/channel/server/wechatpayquery")
public interface WechatPayQueryServiceClient {
	
	@PostMapping("/query")
	public ModelResult<WechatPayQueryResponse> query(@RequestBody WechatPayQueryRequest request);

}
