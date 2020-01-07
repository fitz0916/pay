package com.github.pattern.common.service;

import com.github.appmodel.domain.result.ModelResult;
import com.github.pattern.common.domain.PaymentWhiteList;

public interface PaymentWhiteListService {

	ModelResult<Integer> deleteByPrimaryKey(Integer paymentWhiteListId);

    ModelResult<Integer> insert(PaymentWhiteList record);

    ModelResult<Integer> insertSelective(PaymentWhiteList record);

    ModelResult<PaymentWhiteList> selectByPrimaryKey(Integer paymentWhiteListId);

    ModelResult<Integer> updateByPrimaryKeySelective(PaymentWhiteList record);

    ModelResult<Integer> updateByPrimaryKey(PaymentWhiteList record);
}
