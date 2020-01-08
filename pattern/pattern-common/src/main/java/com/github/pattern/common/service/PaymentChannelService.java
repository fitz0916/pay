package com.github.pattern.common.service;

import com.github.appmodel.domain.result.ModelResult;
import com.github.pattern.common.domain.PaymentChannel;
import com.github.pattern.common.request.PaymentChannelRequest;
import com.github.pattern.common.vo.ResultVo;

public interface PaymentChannelService {

		ModelResult<Integer> deleteByPrimaryKey(Integer payChannelId);

	    ModelResult<Integer> insertSelective(PaymentChannel record);

	    ModelResult<PaymentChannel> selectByPrimaryKey(Integer payChannelId);

	    ModelResult<Integer> updateByPrimaryKeySelective(PaymentChannel record);

	    ModelResult<Integer> updateByPrimaryKey(PaymentChannel record);

		ModelResult<ResultVo> page(PaymentChannelRequest request);
}
