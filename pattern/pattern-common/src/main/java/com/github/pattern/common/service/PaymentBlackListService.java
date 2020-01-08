package com.github.pattern.common.service;

import com.github.appmodel.domain.result.ModelResult;
import com.github.pattern.common.domain.PaymentBlackList;
import com.github.pattern.common.request.PaymentBlackListRequest;
import com.github.pattern.common.vo.ResultVo;

public interface PaymentBlackListService {
	
	ModelResult<Integer> deleteByPrimaryKey(Integer paymentBlackListId);

    ModelResult<Integer> insertSelective(PaymentBlackList record);

    ModelResult<PaymentBlackList> selectByPrimaryKey(Integer paymentBlackListId);

    ModelResult<Integer> updateByPrimaryKeySelective(PaymentBlackList record);

    ModelResult<Integer> updateByPrimaryKey(PaymentBlackList record);

	ModelResult<ResultVo> page(PaymentBlackListRequest request);

}
