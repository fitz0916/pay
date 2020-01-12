package com.github.pattern.client.service;

import java.util.List;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.github.appmodel.domain.result.ModelResult;
import com.github.pattern.common.domain.PaymentChannelAccount;
import com.github.pattern.common.domain.PaymentChannelAccountPara;


@FeignClient(name="pattern-server")
@RequestMapping("/pattern/server/paymentChannelAccountPara")
public interface PaymentChannelAccountParaServiceClient {
	
	
	@PostMapping("/deleteByPrimaryKey/{PaymentChannelAccountParaId}")
	ModelResult<Integer> deleteByPrimaryKey(@PathVariable("PaymentChannelAccountParaId")Integer PaymentChannelAccountParaId);

	@PostMapping("/insert")
	ModelResult<Integer> insert(@RequestBody PaymentChannelAccountPara record);

	@PostMapping("/insertSelective")
	ModelResult<Integer> insertSelective(@RequestBody PaymentChannelAccountPara record);

	@PostMapping("/selectByPrimaryKey/{PaymentChannelAccountParaId}")
	ModelResult<PaymentChannelAccountPara> selectByPrimaryKey(@PathVariable("PaymentChannelAccountParaId")Integer PaymentChannelAccountParaId);

	@PostMapping("/updateByPrimaryKeySelective")
	ModelResult<Integer> updateByPrimaryKeySelective(@RequestBody PaymentChannelAccountPara record);

	@PostMapping("/updateByPrimaryKey")
	ModelResult<Integer> updateByPrimaryKey(@RequestBody PaymentChannelAccount record);

	@PostMapping("/selectByPaymentChannelAccountId/{paymentChannelAccountId}")
	ModelResult<List<PaymentChannelAccountPara>> selectByPaymentChannelAccountId(@PathVariable("paymentChannelAccountId")Integer paymentChannelAccountId);

}
