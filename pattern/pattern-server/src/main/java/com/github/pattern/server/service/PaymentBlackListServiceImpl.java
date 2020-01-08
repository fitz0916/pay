package com.github.pattern.server.service;

import org.springframework.stereotype.Service;

import com.github.appmodel.domain.result.ModelResult;
import com.github.pattern.common.domain.PaymentBlackList;
import com.github.pattern.common.request.PaymentBlackListRequest;
import com.github.pattern.common.service.PaymentBlackListService;
import com.github.pattern.common.vo.ResultVo;

@Service
public class PaymentBlackListServiceImpl implements PaymentBlackListService{

	@Override
	public ModelResult<Integer> deleteByPrimaryKey(Integer paymentBlackListId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ModelResult<Integer> insertSelective(PaymentBlackList record) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ModelResult<PaymentBlackList> selectByPrimaryKey(Integer paymentBlackListId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ModelResult<Integer> updateByPrimaryKeySelective(PaymentBlackList record) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ModelResult<Integer> updateByPrimaryKey(PaymentBlackList record) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ModelResult<ResultVo> page(PaymentBlackListRequest request) {
		// TODO Auto-generated method stub
		return null;
	}
	
	

}
