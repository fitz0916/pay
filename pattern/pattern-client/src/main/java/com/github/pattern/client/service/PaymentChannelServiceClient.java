package com.github.pattern.client.service;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.github.appmodel.domain.result.ModelResult;
import com.github.pattern.common.domain.PaymentChannel;
import com.github.pattern.common.request.PaymentChannelRequest;
import com.github.pattern.common.vo.ResultVo;


@FeignClient(name="pattern-server")
@RequestMapping("/pattern/server/paymentChannel")
public interface PaymentChannelServiceClient {

		@PostMapping("/page")
		ModelResult<ResultVo> page(@RequestBody PaymentChannelRequest request);
	
		@PostMapping("/deleteByPrimaryKey/{payChannelId}")
		ModelResult<Integer> deleteByPrimaryKey(@PathVariable("paymentTypeId")Integer payChannelId);

		@PostMapping("/insertSelective")
	    ModelResult<Integer> insertSelective(@RequestBody PaymentChannel record);

		@PostMapping("/selectByPrimaryKey/{payChannelId}")
	    ModelResult<PaymentChannel> selectByPrimaryKey(@PathVariable("paymentTypeId")Integer payChannelId);

		@PostMapping("/updateByPrimaryKeySelective")
	    ModelResult<Integer> updateByPrimaryKeySelective(@RequestBody PaymentChannel record);

		@PostMapping("/updateByPrimaryKey")
	    ModelResult<Integer> updateByPrimaryKey(@RequestBody PaymentChannel record);
}
