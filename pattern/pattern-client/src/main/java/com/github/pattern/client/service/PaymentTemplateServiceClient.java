package com.github.pattern.client.service;

import java.util.List;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.github.appmodel.domain.result.ModelResult;
import com.github.pattern.common.domain.PaymentTemplate;

@FeignClient(name="pattern-server")
@RequestMapping("/pattern/server/paymentTemplate")
public interface PaymentTemplateServiceClient {
	
	@PostMapping("/selectByPayType/{payType}")
	public ModelResult<List<PaymentTemplate>> selectByPayType(@PathVariable("payType")String payType);

	@PostMapping("/selectByPrimaryKey/{paymentTemplateId}")
	public ModelResult<PaymentTemplate> selectByPrimaryKey(Integer paymentTemplateId);

}
