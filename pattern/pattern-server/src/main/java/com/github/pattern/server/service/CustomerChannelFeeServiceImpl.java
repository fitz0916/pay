package com.github.pattern.server.service;

import org.springframework.stereotype.Service;

import com.github.appmodel.domain.result.ModelResult;
import com.github.pattern.common.domain.CustomerPaymentChannelFee;
import com.github.pattern.common.request.CustomerPaymentChannelFeeRequest;
import com.github.pattern.common.service.CustomerChannelFeeService;
import com.github.pattern.common.vo.ResultVo;


@Service
public class CustomerChannelFeeServiceImpl implements CustomerChannelFeeService{

	@Override
	public ModelResult<Integer> deleteByPrimaryKey(Integer paymentChanneldFeeId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ModelResult<Integer> insert(CustomerPaymentChannelFee record) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ModelResult<Integer> insertSelective(CustomerPaymentChannelFee record) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ModelResult<CustomerPaymentChannelFee> selectByPrimaryKey(Integer paymentChanneldFeeId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ModelResult<Integer> updateByPrimaryKeySelective(CustomerPaymentChannelFee record) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ModelResult<Integer> updateByPrimaryKey(CustomerPaymentChannelFee record) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ModelResult<ResultVo> page(CustomerPaymentChannelFeeRequest request) {
		// TODO Auto-generated method stub
		return null;
	}
	
	

}
