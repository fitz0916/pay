package com.github.pattern.client.service;

import java.util.List;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.github.appmodel.domain.result.ModelResult;
import com.github.pattern.common.domain.PaymentChannelAccount;
import com.github.pattern.common.request.PaymentChannelAccountRequest;
import com.github.pattern.common.vo.PageVo;


@FeignClient(name="pattern-server")
@RequestMapping("/pattern/server/paymentChannelAccount")
public interface PaymentChannelAccountServiceClient {
	
	@PostMapping("/page")
	ModelResult<PageVo> page(@RequestBody PaymentChannelAccountRequest request);
	
	@PostMapping("/deleteByPrimaryKey/{paymentChannelAccountId}")
	ModelResult<Integer> deleteByPrimaryKey(@PathVariable("paymentChannelAccountParaId")Integer paymentChannelAccountId);

	@PostMapping("/insertSelective")
	ModelResult<Integer> insertSelective(@RequestBody PaymentChannelAccount record);

	@PostMapping("/selectByPrimaryKey/{paymentChannelAccountId}")
	ModelResult<PaymentChannelAccount> selectByPrimaryKey(@PathVariable("paymentChannelAccountId")Integer paymentChannelAccountId);

	@PostMapping("/updateByPrimaryKeySelective")
	ModelResult<Integer> updateByPrimaryKeySelective(@RequestBody PaymentChannelAccount record);

	@PostMapping("/updateByPrimaryKey")
	ModelResult<Integer> updateByPrimaryKey(@RequestBody PaymentChannelAccount record);
	
	@PostMapping("/selectByPaymentChannelId/{paymentChannelId}")
	ModelResult<List<PaymentChannelAccount>> selectByPaymentChannelId(@PathVariable("paymentChannelId")Integer paymentChannelId);

}
