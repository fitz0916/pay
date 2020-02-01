package com.github.pattern.common.service;

import java.util.List;

import com.github.appmodel.domain.result.ModelResult;
import com.github.appmodel.vo.PageVo;
import com.github.pattern.common.domain.PaymentChannel;
import com.github.pattern.common.request.PaymentChannelRequest;

public interface PaymentChannelService {

		ModelResult<Integer> deleteByPrimaryKey(Integer payChannelId);

	    ModelResult<Integer> insertSelective(PaymentChannel record);

	    ModelResult<PaymentChannel> selectByPrimaryKey(Integer payChannelId);

	    ModelResult<Integer> updateByPrimaryKeySelective(PaymentChannel record);

	    ModelResult<Integer> updateByPrimaryKey(PaymentChannel record);

		ModelResult<PageVo> page(PaymentChannelRequest request);

		ModelResult<List<PaymentChannel>> list();
}
