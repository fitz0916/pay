package com.github.pattern.client.service;

import java.util.List;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.github.appmodel.domain.result.ModelResult;
import com.github.appmodel.vo.PageVo;
import com.github.pattern.common.domain.PaymentChannel;
import com.github.pattern.common.request.PaymentChannelRequest;


@FeignClient(name="pattern-server")
@RequestMapping("/pattern/server/paymentChannel")
public interface PaymentChannelServiceClient {

		@PostMapping("/page")
		ModelResult<PageVo> page(@RequestBody PaymentChannelRequest request);
	
		@PostMapping("/deleteByPrimaryKey/{paymentChannelId}")
		ModelResult<Integer> deleteByPrimaryKey(@PathVariable("paymentChannelId")Integer paymentChannelId);

		@PostMapping("/insertSelective")
	    ModelResult<Integer> insertSelective(@RequestBody PaymentChannel record);

		@PostMapping("/selectByPrimaryKey/{paymentChannelId}")
	    ModelResult<PaymentChannel> selectByPrimaryKey(@PathVariable("paymentChannelId")Integer paymentChannelId);

		@PostMapping("/updateByPrimaryKeySelective")
	    ModelResult<Integer> updateByPrimaryKeySelective(@RequestBody PaymentChannel record);

		@PostMapping("/updateByPrimaryKey")
	    ModelResult<Integer> updateByPrimaryKey(@RequestBody PaymentChannel record);
		
		@PostMapping("/list")
	    ModelResult<List<PaymentChannel>> list();
		
}
