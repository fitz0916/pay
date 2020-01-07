package com.github.pattern.common.service;

import com.github.appmodel.domain.result.ModelResult;
import com.github.pattern.common.domain.PaymentChannelAccountPara;

public interface PaymentChannelAccountService {
	
	ModelResult<Integer> deleteByPrimaryKey(Integer paymentChannelAccountParaId);

    ModelResult<Integer> insertSelective(PaymentChannelAccountPara record);

    ModelResult<PaymentChannelAccountPara> selectByPrimaryKey(Integer paymentChannelAccountParaId);

    ModelResult<Integer> updateByPrimaryKeySelective(PaymentChannelAccountPara record);

    ModelResult<Integer> updateByPrimaryKeyWithBLOBs(PaymentChannelAccountPara record);

    ModelResult<Integer> updateByPrimaryKey(PaymentChannelAccountPara record);

}
