package com.github.pattern.common.service;

import com.github.appmodel.domain.result.ModelResult;
import com.github.pattern.common.domain.PaymentChannelAccount;

public interface PaymentChannelAccountParaService {
	
	ModelResult<Integer> deleteByPrimaryKey(Integer paymentChannelAccountId);

    ModelResult<Integer> insert(PaymentChannelAccount record);

    ModelResult<Integer> insertSelective(PaymentChannelAccount record);

    ModelResult<PaymentChannelAccount> selectByPrimaryKey(Integer paymentChannelAccountId);

    ModelResult<Integer> updateByPrimaryKeySelective(PaymentChannelAccount record);

    ModelResult<Integer> updateByPrimaryKey(PaymentChannelAccount record);

}
