package com.github.pattern.common.service;

import com.github.appmodel.domain.result.ModelResult;
import com.github.pattern.common.domain.Customer;

public interface CustomerService {
	
	ModelResult<Integer> deleteByPrimaryKey(Integer customerId);

    ModelResult<Integer> insertSelective(Customer record);

    ModelResult<Customer> selectByPrimaryKey(Integer customerId);

    ModelResult<Integer> updateByPrimaryKeySelective(Customer record);

    ModelResult<Integer> updateByPrimaryKey(Customer record);

}
