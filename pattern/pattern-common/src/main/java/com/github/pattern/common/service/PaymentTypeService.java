package com.github.pattern.common.service;

import com.github.appmodel.domain.result.ModelResult;
import com.github.pattern.common.domain.PaymentType;

public interface PaymentTypeService {

	ModelResult<Integer> deleteByPrimaryKey(Integer paymentTypeId);

    ModelResult<Integer> insert(PaymentType record);

    ModelResult<Integer> insertSelective(PaymentType record);

    ModelResult<PaymentType> selectByPrimaryKey(Integer paymentTypeId);

    ModelResult<Integer> updateByPrimaryKeySelective(PaymentType record);

    ModelResult<Integer> updateByPrimaryKey(PaymentType record);
}
