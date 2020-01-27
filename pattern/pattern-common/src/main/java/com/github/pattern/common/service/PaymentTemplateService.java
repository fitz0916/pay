package com.github.pattern.common.service;

import java.util.List;

import com.github.appmodel.domain.result.ModelResult;
import com.github.pattern.common.domain.PaymentTemplate;

public interface PaymentTemplateService {
	
    public ModelResult<List<PaymentTemplate>> selectByPayType(String payType);

	public ModelResult<PaymentTemplate> selectByPrimaryKey(Integer paymentTemplateId);
}