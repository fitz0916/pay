package com.github.pattern.server.service;

import org.springframework.stereotype.Service;

import com.github.appmodel.domain.result.ModelResult;
import com.github.pattern.common.domain.PaymentType;
import com.github.pattern.common.request.PaymentTypeRequest;
import com.github.pattern.common.service.PaymentTypeService;
import com.github.pattern.common.vo.ResultVo;


@Service
public class PaymentTypeServiceImpl implements PaymentTypeService{

	@Override
	public ModelResult<Integer> deleteByPrimaryKey(Integer paymentTypeId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ModelResult<Integer> insert(PaymentType record) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ModelResult<Integer> insertSelective(PaymentType record) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ModelResult<PaymentType> selectByPrimaryKey(Integer paymentTypeId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ModelResult<Integer> updateByPrimaryKeySelective(PaymentType record) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ModelResult<Integer> updateByPrimaryKey(PaymentType record) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ModelResult<ResultVo> page(PaymentTypeRequest request) {
		// TODO Auto-generated method stub
		return null;
	}

	
}
