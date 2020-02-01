package com.github.trans.server.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.github.trans.common.domain.PaymentOrder;

@Repository
public interface PaymentOrderDao {
	
    int deleteByPrimaryKey(String orderNo);

    int insert(PaymentOrder record);

    int insertSelective(PaymentOrder record);

    PaymentOrder selectByPrimaryKey(String orderNo);

    int updateByPrimaryKeySelective(PaymentOrder record);

    int updateByPrimaryKey(PaymentOrder record);
    
    List<PaymentOrder> selectByCstomerOrderNo(String customerOrderNo);

	long pageCount(@Param("customerNo")String customerNo, @Param("customerOrderNo")String customerOrderNo);

	List<PaymentOrder> pageList(@Param("start")int start, @Param("offset")int offset, @Param("customerNo")String customerNo, @Param("customerOrderNo")String customerOrderNo);
    
    
    
}