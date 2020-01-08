package com.github.pattern.server.service;

import org.springframework.stereotype.Service;

import com.github.appmodel.domain.result.ModelResult;
import com.github.pattern.common.domain.PaymentChannelAccount;
import com.github.pattern.common.request.PaymentChannelAccountRequest;
import com.github.pattern.common.service.PaymentChannelAccountService;
import com.github.pattern.common.vo.ResultVo;

@Service
public class PaymentChannelAccountServiceImpl implements PaymentChannelAccountService{

	@Override
	public ModelResult<Integer> deleteByPrimaryKey(Integer paymentChannelAccountId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ModelResult<Integer> insertSelective(PaymentChannelAccount record) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ModelResult<PaymentChannelAccount> selectByPrimaryKey(Integer paymentChannelAccountId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ModelResult<Integer> updateByPrimaryKeySelective(PaymentChannelAccount record) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ModelResult<Integer> updateByPrimaryKeyWithBLOBs(PaymentChannelAccount record) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ModelResult<Integer> updateByPrimaryKey(PaymentChannelAccount record) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ModelResult<ResultVo> page(PaymentChannelAccountRequest request) {
		// TODO Auto-generated method stub
		return null;
	}
	
	

}
