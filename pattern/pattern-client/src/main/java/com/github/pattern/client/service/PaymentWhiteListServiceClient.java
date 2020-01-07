package com.github.pattern.client.service;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.github.appmodel.domain.result.ModelResult;
import com.github.pattern.common.domain.PaymentWhiteList;



@FeignClient(name="pattern-server")
@RequestMapping("/pattern/server/paymentWhiteList")
public interface PaymentWhiteListServiceClient {

	@PostMapping("/deleteByPrimaryKey/{paymentWhiteListId}")
	ModelResult<Integer> deleteByPrimaryKey(@PathVariable("paymentWhiteListId")Integer paymentWhiteListId);

	@PostMapping("/insert")
    ModelResult<Integer> insert(@RequestBody PaymentWhiteList record);

	@PostMapping("/insertSelective")
    ModelResult<Integer> insertSelective(@RequestBody PaymentWhiteList record);

	@PostMapping("/selectByPrimaryKey/{paymentWhiteListId}")
    ModelResult<PaymentWhiteList> selectByPrimaryKey(@PathVariable Integer paymentWhiteListId);

	@PostMapping("/updateByPrimaryKeySelective")
    ModelResult<Integer> updateByPrimaryKeySelective(@RequestBody PaymentWhiteList record);

	@PostMapping("/updateByPrimaryKey")
    ModelResult<Integer> updateByPrimaryKey(@RequestBody PaymentWhiteList record);
}
