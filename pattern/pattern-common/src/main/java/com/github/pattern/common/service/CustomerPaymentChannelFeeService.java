package com.github.pattern.common.service;

import com.github.appmodel.domain.result.ModelResult;
import com.github.pattern.common.domain.CustomerPaymentChannelFee;
import com.github.pattern.common.request.CustomerPaymentChannelFeeRequest;
import com.github.pattern.common.vo.ResultVo;

public interface CustomerPaymentChannelFeeService {
	
	ModelResult<Integer> deleteByPrimaryKey(Integer paymentChanneldFeeId);

    ModelResult<Integer> insert(CustomerPaymentChannelFee record);

    ModelResult<Integer> insertSelective(CustomerPaymentChannelFee record);

    ModelResult<CustomerPaymentChannelFee> selectByPrimaryKey(Integer paymentChanneldFeeId);

    ModelResult<Integer> updateByPrimaryKeySelective(CustomerPaymentChannelFee record);

    ModelResult<Integer> updateByPrimaryKey(CustomerPaymentChannelFee record);

	ModelResult<ResultVo> page(CustomerPaymentChannelFeeRequest request);

}
