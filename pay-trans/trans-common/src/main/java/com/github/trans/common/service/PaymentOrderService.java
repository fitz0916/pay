package com.github.trans.common.service;

import com.github.appmodel.domain.result.ModelResult;
import com.github.trans.common.domain.PaymentOrder;

public interface PaymentOrderService {

	ModelResult<Integer> deleteByPrimaryKey(String orderNo);

	ModelResult<Integer> insert(PaymentOrder record);

	ModelResult<Integer> insertSelective(PaymentOrder record);

	ModelResult<PaymentOrder> selectByPrimaryKey(String orderNo);

    ModelResult<Integer> updateByPrimaryKeySelective(PaymentOrder record);

    ModelResult<Integer> updateByPrimaryKey(PaymentOrder record);
    
    ModelResult<PaymentOrder> selectByCstomerOrderNo(String customerOrderNo);
    
    
}
