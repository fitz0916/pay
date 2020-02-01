package com.github.trans.common.service;

import java.util.List;

import com.github.appmodel.domain.result.ModelResult;
import com.github.appmodel.vo.PageVo;
import com.github.trans.common.domain.PaymentOrder;
import com.github.trans.common.request.PaymentOrderRequest;

public interface PaymentOrderService {

	ModelResult<Integer> deleteByPrimaryKey(String orderNo);

	ModelResult<Integer> insert(PaymentOrder record);

	ModelResult<Integer> insertSelective(PaymentOrder record);

	ModelResult<PaymentOrder> selectByPrimaryKey(String orderNo);

    ModelResult<Integer> updateByPrimaryKeySelective(PaymentOrder record);

    ModelResult<Integer> updateByPrimaryKey(PaymentOrder record);
    
    ModelResult<List<PaymentOrder>> selectByCstomerOrderNo(String customerOrderNo);
    
    ModelResult<PageVo> page(PaymentOrderRequest paymentOrderRequest);
    
    
}
