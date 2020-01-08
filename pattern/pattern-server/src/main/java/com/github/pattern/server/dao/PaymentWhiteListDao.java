package com.github.pattern.server.dao;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.github.pattern.common.domain.PaymentWhiteList;


@Repository
public interface PaymentWhiteListDao {
	
	
    int deleteByPrimaryKey(@Param("paymentWhiteListId")Integer paymentWhiteListId);

    int insert(PaymentWhiteList record);

    int insertSelective(PaymentWhiteList record);

    PaymentWhiteList selectByPrimaryKey(@Param("paymentWhiteListId")Integer paymentWhiteListId);

    int updateByPrimaryKeySelective(PaymentWhiteList record);

    int updateByPrimaryKey(PaymentWhiteList record);
}