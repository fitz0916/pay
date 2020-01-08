package com.github.pattern.server.service;

import org.springframework.stereotype.Service;

import com.github.appmodel.domain.result.ModelResult;
import com.github.pattern.common.domain.PaymentWhiteList;
import com.github.pattern.common.request.PaymentWhiteListRequest;
import com.github.pattern.common.service.PaymentWhiteListService;
import com.github.pattern.common.vo.ResultVo;

@Service
public class PaymentWhiteListServiceImpl implements PaymentWhiteListService{

	@Override
	public ModelResult<Integer> deleteByPrimaryKey(Integer paymentWhiteListId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ModelResult<Integer> insert(PaymentWhiteList record) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ModelResult<Integer> insertSelective(PaymentWhiteList record) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ModelResult<PaymentWhiteList> selectByPrimaryKey(Integer paymentWhiteListId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ModelResult<Integer> updateByPrimaryKeySelective(PaymentWhiteList record) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ModelResult<Integer> updateByPrimaryKey(PaymentWhiteList record) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ModelResult<ResultVo> page(PaymentWhiteListRequest request) {
		// TODO Auto-generated method stub
		return null;
	}

	
}
