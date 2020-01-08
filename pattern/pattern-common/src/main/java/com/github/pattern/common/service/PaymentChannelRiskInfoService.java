package com.github.pattern.common.service;

import com.github.appmodel.domain.result.ModelResult;
import com.github.pattern.common.domain.PaymentChannelInfoRisk;
import com.github.pattern.common.request.PaymentChannelInfoRiskRequest;
import com.github.pattern.common.vo.ResultVo;

public interface PaymentChannelRiskInfoService {
	
	ModelResult<Integer> deleteByPrimaryKey(Integer paymentChannelinfoRiskId);

    ModelResult<Integer> insertSelective(PaymentChannelInfoRisk record);

    ModelResult<PaymentChannelInfoRisk> selectByPrimaryKey(Integer paymentChannelinfoRiskId);

    ModelResult<Integer> updateByPrimaryKeySelective(PaymentChannelInfoRisk record);

    ModelResult<Integer> updateByPrimaryKey(PaymentChannelInfoRisk record);

	ModelResult<ResultVo> page(PaymentChannelInfoRiskRequest request);

}
