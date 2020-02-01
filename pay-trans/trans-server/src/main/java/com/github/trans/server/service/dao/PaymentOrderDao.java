package com.github.trans.server.service.dao;

import com.github.trans.common.domain.PaymentOrder;

public interface PaymentOrderDao {
	
    int deleteByPrimaryKey(String orderNo);

    int insert(PaymentOrder record);

    int insertSelective(PaymentOrder record);

    PaymentOrder selectByPrimaryKey(String orderNo);

    int updateByPrimaryKeySelective(PaymentOrder record);

    int updateByPrimaryKey(PaymentOrder record);
    
    PaymentOrder selectByCstomerOrderNo(String customerOrderNo);
}