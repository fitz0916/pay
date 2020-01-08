package com.github.pattern.client.service;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.github.appmodel.domain.result.ModelResult;
import com.github.pattern.common.domain.PaymentChannelAccount;
import com.github.pattern.common.domain.PaymentChannelAccountPara;
import com.github.pattern.common.request.PaymentChannelAccountParaRequest;
import com.github.pattern.common.vo.ResultVo;


@FeignClient(name="pattern-server")
@RequestMapping("/pattern/server/paymentChannelAccountPara")
public interface PaymentChannelAccountParaServiceClient {
	
	@PostMapping("/page")
	ModelResult<ResultVo> page(@RequestBody PaymentChannelAccountParaRequest request);
	
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

}
