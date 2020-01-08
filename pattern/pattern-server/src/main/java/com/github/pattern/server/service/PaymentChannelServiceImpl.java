package com.github.pattern.server.service;

import org.springframework.stereotype.Service;

import com.github.appmodel.domain.result.ModelResult;
import com.github.pattern.common.domain.PaymentChannel;
import com.github.pattern.common.request.PaymentChannelRequest;
import com.github.pattern.common.service.PaymentChannelService;
import com.github.pattern.common.vo.ResultVo;



@Service
public class PaymentChannelServiceImpl implements PaymentChannelService{

	@Override
	public ModelResult<Integer> deleteByPrimaryKey(Integer payChannelId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ModelResult<Integer> insertSelective(PaymentChannel record) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ModelResult<PaymentChannel> selectByPrimaryKey(Integer payChannelId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ModelResult<Integer> updateByPrimaryKeySelective(PaymentChannel record) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ModelResult<Integer> updateByPrimaryKey(PaymentChannel record) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ModelResult<ResultVo> page(PaymentChannelRequest request) {
		// TODO Auto-generated method stub
		return null;
	}

		
}
