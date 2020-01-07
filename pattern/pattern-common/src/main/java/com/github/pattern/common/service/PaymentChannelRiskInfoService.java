package com.github.pattern.common.service;

import com.github.appmodel.domain.result.ModelResult;
import com.github.pattern.common.domain.PaymentChannelInfoRisk;

public interface PaymentChannelRiskInfoService {
	
	ModelResult<Integer> deleteByPrimaryKey(Integer paymentChannelinfoRiskId);

    ModelResult<Integer> insertSelective(PaymentChannelInfoRisk record);

    ModelResult<PaymentChannelInfoRisk> selectByPrimaryKey(Integer paymentChannelinfoRiskId);

    ModelResult<Integer> updateByPrimaryKeySelective(PaymentChannelInfoRisk record);

    ModelResult<Integer> updateByPrimaryKey(PaymentChannelInfoRisk record);

}
