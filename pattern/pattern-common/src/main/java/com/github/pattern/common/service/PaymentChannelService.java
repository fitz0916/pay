package com.github.pattern.common.service;

import com.github.appmodel.domain.result.ModelResult;
import com.github.pattern.common.domain.PaymentChannel;

public interface PaymentChannelService {

		ModelResult<Integer> deleteByPrimaryKey(Integer payChannelId);

	    ModelResult<Integer> insertSelective(PaymentChannel record);

	    ModelResult<PaymentChannel> selectByPrimaryKey(Integer payChannelId);

	    ModelResult<Integer> updateByPrimaryKeySelective(PaymentChannel record);

	    ModelResult<Integer> updateByPrimaryKey(PaymentChannel record);
}
