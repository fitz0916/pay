package com.github.pattern.server.dao;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.github.pattern.common.domain.PaymentType;


@Repository
public interface PaymentTypeDao {
	
	
    int deleteByPrimaryKey(@Param("paymentTypeId")Integer paymentTypeId);

    int insert(PaymentType record);

    int insertSelective(PaymentType record);

    PaymentType selectByPrimaryKey(@Param("paymentTypeId")Integer paymentTypeId);

    int updateByPrimaryKeySelective(PaymentType record);

    int updateByPrimaryKey(PaymentType record);
}