package com.github.pattern.common.service;

import java.util.List;

import com.github.appmodel.domain.result.ModelResult;
import com.github.appmodel.vo.PageVo;
import com.github.pattern.common.domain.CustomerPaymentChannelInfo;
import com.github.pattern.common.request.CustomerPaymentChannelInfoRequest;

public interface CustomerPaymentChannelInfoService {
	
	ModelResult<Integer> deleteByPrimaryKey(Integer customerPaymentChannelInfoId);

    ModelResult<Integer> insertSelective(CustomerPaymentChannelInfo record);

    ModelResult<CustomerPaymentChannelInfo> selectByPrimaryKey(Integer customerPaymentChannelInfoId);

    ModelResult<Integer> updateByPrimaryKeySelective(CustomerPaymentChannelInfo record);

    ModelResult<Integer> updateByPrimaryKey(CustomerPaymentChannelInfo record);

	ModelResult<PageVo> page(CustomerPaymentChannelInfoRequest request);

	ModelResult<PageVo> paymentChannelInfoPage(CustomerPaymentChannelInfoRequest request);

	ModelResult<List<CustomerPaymentChannelInfo>> selectByCustomerIdAndPayType(Integer customerId, String payType);

}
