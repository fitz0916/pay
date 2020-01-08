package com.github.pattern.server.service;

import org.springframework.stereotype.Service;

import com.github.appmodel.domain.result.ModelResult;
import com.github.pattern.common.domain.CustomerPaymentChannelInfo;
import com.github.pattern.common.request.CustomerPaymentChannelInfoRequest;
import com.github.pattern.common.service.CustomerPaymentChannelInfoService;
import com.github.pattern.common.vo.ResultVo;


@Service
public class CustomerPaymentChannelInfoServiceImpl implements CustomerPaymentChannelInfoService{

	@Override
	public ModelResult<Integer> deleteByPrimaryKey(Integer customerPaymentChannelInfoId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ModelResult<Integer> insertSelective(CustomerPaymentChannelInfo record) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ModelResult<CustomerPaymentChannelInfo> selectByPrimaryKey(Integer customerPaymentChannelInfoId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ModelResult<Integer> updateByPrimaryKeySelective(CustomerPaymentChannelInfo record) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ModelResult<Integer> updateByPrimaryKey(CustomerPaymentChannelInfo record) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ModelResult<ResultVo> page(CustomerPaymentChannelInfoRequest request) {
		// TODO Auto-generated method stub
		return null;
	}
	
	

}
