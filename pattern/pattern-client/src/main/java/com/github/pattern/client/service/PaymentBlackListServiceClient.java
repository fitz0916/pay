package com.github.pattern.client.service;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.github.appmodel.domain.result.ModelResult;
import com.github.pattern.common.domain.PaymentBlackList;
import com.github.pattern.common.request.PaymentBlackListRequest;
import com.github.pattern.common.vo.ResultVo;

@FeignClient(name="pattern-server")
@RequestMapping("/pattern/server/paymentBlackList")
public interface PaymentBlackListServiceClient {
	
	@PostMapping("/page")
	ModelResult<ResultVo> page(@RequestBody PaymentBlackListRequest request);
	
	@PostMapping("/deleteByPrimaryKey/{paymentBlackListId}")
	ModelResult<Integer> deleteByPrimaryKey(@PathVariable("paymentBlackListId")Integer paymentBlackListId);

	@PostMapping("/insertSelective")
	ModelResult<Integer> insertSelective(@RequestBody PaymentBlackList record);

	@PostMapping("/selectByPrimaryKey/{paymentBlackListId}")
	ModelResult<PaymentBlackList> selectByPrimaryKey(@PathVariable("paymentBlackListId")Integer paymentBlackListId);
	
	@PostMapping("/updateByPrimaryKeySelective")
    ModelResult<Integer> updateByPrimaryKeySelective(@RequestBody PaymentBlackList record);

	@PostMapping("/updateByPrimaryKey")
    ModelResult<Integer> updateByPrimaryKey(@RequestBody PaymentBlackList record);

}
