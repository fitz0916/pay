package com.github.pattern.server.dao;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.github.pattern.common.domain.PaymentBlackList;

@Repository
public interface PaymentBlackListDao {
	
    int deleteByPrimaryKey(@Param("paymentBlackListId")Integer paymentBlackListId);

    int insert(PaymentBlackList record);

    int insertSelective(PaymentBlackList record);

    PaymentBlackList selectByPrimaryKey(@Param("paymentBlackListId")Integer paymentBlackListId);

    int updateByPrimaryKeySelective(PaymentBlackList record);

    int updateByPrimaryKey(PaymentBlackList record);
}