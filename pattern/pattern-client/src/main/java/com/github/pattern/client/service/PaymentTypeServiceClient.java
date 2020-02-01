package com.github.pattern.client.service;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.github.appmodel.domain.result.ModelResult;
import com.github.appmodel.vo.ResultVo;
import com.github.pattern.common.domain.PaymentType;
import com.github.pattern.common.request.PaymentTypeRequest;


@FeignClient(name="pattern-server")
@RequestMapping("/pattern/server/paymentType")
public interface PaymentTypeServiceClient {

	@PostMapping("/page")
	ModelResult<ResultVo> page(@RequestBody PaymentTypeRequest request);
	
	@PostMapping("/deleteByPrimaryKey/{paymentTypeId}")
	ModelResult<Integer> deleteByPrimaryKey(@PathVariable("paymentTypeId")Integer paymentTypeId);

	@PostMapping("/insert")
    ModelResult<Integer> insert(@RequestBody PaymentType record);

	@PostMapping("/insertSelective")
    ModelResult<Integer> insertSelective(@RequestBody PaymentType record);

	@PostMapping("/selectByPrimaryKey/{paymentTypeId}")
    ModelResult<PaymentType> selectByPrimaryKey(@PathVariable("paymentTypeId")Integer paymentTypeId);

	@PostMapping("/updateByPrimaryKeySelective")
    ModelResult<Integer> updateByPrimaryKeySelective(@RequestBody PaymentType record);

	@PostMapping("/updateByPrimaryKey")
    ModelResult<Integer> updateByPrimaryKey(@RequestBody PaymentType record);
}
