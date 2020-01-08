package com.github.pattern.server.service;

import org.springframework.stereotype.Service;

import com.github.appmodel.domain.result.ModelResult;
import com.github.pattern.common.domain.PaymentChannelInfoRisk;
import com.github.pattern.common.request.PaymentChannelInfoRiskRequest;
import com.github.pattern.common.service.PaymentChannelRiskInfoService;
import com.github.pattern.common.vo.ResultVo;


@Service
public class PaymentChannelRiskInfoServiceImpl implements PaymentChannelRiskInfoService{

	@Override
	public ModelResult<Integer> deleteByPrimaryKey(Integer paymentChannelinfoRiskId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ModelResult<Integer> insertSelective(PaymentChannelInfoRisk record) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ModelResult<PaymentChannelInfoRisk> selectByPrimaryKey(Integer paymentChannelinfoRiskId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ModelResult<Integer> updateByPrimaryKeySelective(PaymentChannelInfoRisk record) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ModelResult<Integer> updateByPrimaryKey(PaymentChannelInfoRisk record) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ModelResult<ResultVo> page(PaymentChannelInfoRiskRequest request) {
		// TODO Auto-generated method stub
		return null;
	}
	
	

}
