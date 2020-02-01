package com.github.pattern.client.service;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.github.appmodel.domain.result.ModelResult;
import com.github.appmodel.vo.ResultVo;
import com.github.pattern.common.domain.PaymentChannelInfoRisk;
import com.github.pattern.common.request.PaymentChannelInfoRiskRequest;


@FeignClient(name="pattern-server")
@RequestMapping("/pattern/server/paymentChannelRiskInfo")
public interface PaymentChannelRiskInfoServiceClient {
	
	@PostMapping("/page")
	ModelResult<ResultVo> page(@RequestBody PaymentChannelInfoRiskRequest request);
	
	@PostMapping("/deleteByPrimaryKey/{paymentChannelinfoRiskId}")
	ModelResult<Integer> deleteByPrimaryKey(@PathVariable("paymentChannelinfoRiskId")Integer paymentChannelinfoRiskId);

	@PostMapping("/insertSelective")
    ModelResult<Integer> insertSelective(@RequestBody PaymentChannelInfoRisk record);

	@PostMapping("/selectByPrimaryKey/{paymentChannelinfoRiskId}")
    ModelResult<PaymentChannelInfoRisk> selectByPrimaryKey(@PathVariable("paymentChannelinfoRiskId")Integer paymentChannelinfoRiskId);

	@PostMapping("/updateByPrimaryKeySelective")
    ModelResult<Integer> updateByPrimaryKeySelective(@RequestBody PaymentChannelInfoRisk record);

	@PostMapping("/updateByPrimaryKey")
    ModelResult<Integer> updateByPrimaryKey(@RequestBody PaymentChannelInfoRisk record);

}
