package com.github.pattern.server.service;

import org.springframework.stereotype.Service;

import com.github.appmodel.domain.result.ModelResult;
import com.github.pattern.common.domain.PaymentChannelAccountPara;
import com.github.pattern.common.request.PaymentChannelAccountParaRequest;
import com.github.pattern.common.service.PaymentChannelAccountParaService;
import com.github.pattern.common.vo.ResultVo;


@Service
public class PaymentChannelAccountParaServiceImpl implements PaymentChannelAccountParaService{

	@Override
	public ModelResult<Integer> deleteByPrimaryKey(Integer PaymentChannelAccountParaId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ModelResult<Integer> insert(PaymentChannelAccountPara record) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ModelResult<Integer> insertSelective(PaymentChannelAccountPara record) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ModelResult<PaymentChannelAccountPara> selectByPrimaryKey(Integer PaymentChannelAccountParaId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ModelResult<Integer> updateByPrimaryKeySelective(PaymentChannelAccountPara record) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ModelResult<Integer> updateByPrimaryKey(PaymentChannelAccountPara record) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ModelResult<ResultVo> page(PaymentChannelAccountParaRequest request) {
		// TODO Auto-generated method stub
		return null;
	}
	
	

}
