package com.github.pattern.common.service;

import com.github.appmodel.domain.result.ModelResult;
import com.github.pattern.common.domain.CustomerPaymentChannelFee;

public interface CustomerChannelFeeService {
	
	ModelResult<Integer> deleteByPrimaryKey(Integer paymentChanneldFeeId);

    ModelResult<Integer> insert(CustomerPaymentChannelFee record);

    ModelResult<Integer> insertSelective(CustomerPaymentChannelFee record);

    ModelResult<CustomerPaymentChannelFee> selectByPrimaryKey(Integer paymentChanneldFeeId);

    ModelResult<Integer> updateByPrimaryKeySelective(CustomerPaymentChannelFee record);

    ModelResult<Integer> updateByPrimaryKey(CustomerPaymentChannelFee record);

}
