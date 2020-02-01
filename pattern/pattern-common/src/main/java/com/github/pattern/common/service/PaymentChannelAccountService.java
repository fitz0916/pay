package com.github.pattern.common.service;

import java.util.List;

import com.github.appmodel.domain.result.ModelResult;
import com.github.appmodel.vo.ResultVo;
import com.github.pattern.common.domain.PaymentChannelAccount;
import com.github.pattern.common.request.PaymentChannelAccountRequest;

public interface PaymentChannelAccountService {
	
	ModelResult<Integer> deleteByPrimaryKey(Integer paymentChannelAccountId);

    ModelResult<Integer> insertSelective(PaymentChannelAccount record);

    ModelResult<PaymentChannelAccount> selectByPrimaryKey(Integer paymentChannelAccountId);

    ModelResult<Integer> updateByPrimaryKeySelective(PaymentChannelAccount record);

    ModelResult<Integer> updateByPrimaryKey(PaymentChannelAccount record);

	ModelResult<ResultVo> page(PaymentChannelAccountRequest request);
	
	
	ModelResult<List<PaymentChannelAccount>> selectByPaymentChannelId(Integer paymentChannelId);

}
