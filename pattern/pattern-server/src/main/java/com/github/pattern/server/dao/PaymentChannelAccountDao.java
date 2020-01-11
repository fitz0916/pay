package com.github.pattern.server.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.github.pattern.common.domain.PaymentChannelAccount;


@Repository
public interface PaymentChannelAccountDao {
	
	
    int deleteByPrimaryKey(@Param("paymentChannelAccountId")Integer paymentChannelAccountId);

    int insert(PaymentChannelAccount record);

    int insertSelective(PaymentChannelAccount record);

    PaymentChannelAccount selectByPrimaryKey(@Param("paymentChannelAccountId")Integer paymentChannelAccountId);

    int updateByPrimaryKeySelective(PaymentChannelAccount record);

    int updateByPrimaryKey(PaymentChannelAccount record);

	List<PaymentChannelAccount> selectByPaymentChannelId(@Param("paymentChannelId")Integer paymentChannelId);
}