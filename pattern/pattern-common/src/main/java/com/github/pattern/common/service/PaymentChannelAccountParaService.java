package com.github.pattern.common.service;

import java.util.List;

import com.github.appmodel.domain.result.ModelResult;
import com.github.pattern.common.domain.PaymentChannelAccountPara;
import com.github.pattern.common.request.PaymentChannelAccountParaRequest;
import com.github.pattern.common.vo.ResultVo;

public interface PaymentChannelAccountParaService {
	
	ModelResult<Integer> deleteByPrimaryKey(Integer paymentChannelAccountParaId);

    ModelResult<Integer> insert(PaymentChannelAccountPara record);

    ModelResult<Integer> insertSelective(PaymentChannelAccountPara record);

    ModelResult<PaymentChannelAccountPara> selectByPrimaryKey(Integer paymentChannelAccountParaId);

    ModelResult<Integer> updateByPrimaryKeySelective(PaymentChannelAccountPara record);

    ModelResult<Integer> updateByPrimaryKey(PaymentChannelAccountPara record);

	ModelResult<List<PaymentChannelAccountPara>> selectByPaymentChannelAccountId(Integer paymentChannelAccountId);


}
