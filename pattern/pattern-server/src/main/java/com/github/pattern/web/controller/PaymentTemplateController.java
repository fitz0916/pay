package com.github.pattern.web.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.github.appmodel.domain.result.ModelResult;
import com.github.pattern.common.domain.PaymentTemplate;
import com.github.pattern.common.service.PaymentTemplateService;

@RestController
@RequestMapping("/pattern/server/paymentTemplate")
public class PaymentTemplateController {

	@Autowired
	private PaymentTemplateService paymentTemplateServiceImpl;
	
	@PostMapping("/selectByPayType/{payType}")
	public ModelResult<List<PaymentTemplate>> selectByPayType(@PathVariable("payType")String payType){
		return paymentTemplateServiceImpl.selectByPayType(payType);
	}
	
	@PostMapping("/selectByPrimaryKey/{paymentTemplateId}")
	public ModelResult<PaymentTemplate> selectByPrimaryKey(@PathVariable("paymentTemplateId")Integer paymentTemplateId){
		return paymentTemplateServiceImpl.selectByPrimaryKey(paymentTemplateId);
	}
}
