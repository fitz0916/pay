package com.github.pattern.server.service;

import org.springframework.stereotype.Service;

import com.github.appmodel.domain.result.ModelResult;
import com.github.pattern.common.domain.Customer;
import com.github.pattern.common.request.CustomerRequest;
import com.github.pattern.common.service.CustomerService;
import com.github.pattern.common.vo.ResultVo;


@Service
public class CustomerServiceImpl implements CustomerService{

	@Override
	public ModelResult<Integer> deleteByPrimaryKey(Integer customerId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ModelResult<Integer> insertSelective(Customer record) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ModelResult<Customer> selectByPrimaryKey(Integer customerId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ModelResult<Integer> updateByPrimaryKeySelective(Customer record) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ModelResult<Integer> updateByPrimaryKey(Customer record) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ModelResult<ResultVo> page(CustomerRequest request) {
		// TODO Auto-generated method stub
		return null;
	}
	
	

}
