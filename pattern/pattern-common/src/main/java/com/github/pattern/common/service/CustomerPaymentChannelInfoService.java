package com.github.pattern.common.service;

import com.github.appmodel.domain.result.ModelResult;
import com.github.pattern.common.domain.CustomerPaymentChannelInfo;
import com.github.pattern.common.request.CustomerPaymentChannelInfoRequest;
import com.github.pattern.common.vo.ResultVo;

public interface CustomerPaymentChannelInfoService {
	
	ModelResult<Integer> deleteByPrimaryKey(Integer customerPaymentChannelInfoId);

    ModelResult<Integer> insertSelective(CustomerPaymentChannelInfo record);

    ModelResult<CustomerPaymentChannelInfo> selectByPrimaryKey(Integer customerPaymentChannelInfoId);

    ModelResult<Integer> updateByPrimaryKeySelective(CustomerPaymentChannelInfo record);

    ModelResult<Integer> updateByPrimaryKey(CustomerPaymentChannelInfo record);

	ModelResult<ResultVo> page(CustomerPaymentChannelInfoRequest request);

}
