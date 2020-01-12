package com.github.pattern.server.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.github.pattern.common.domain.PaymentChannelAccountPara;

@Repository
public interface PaymentChannelAccountParaDao {
	
	
    int deleteByPrimaryKey(@Param("paymentChannelAccountParaId")Integer paymentChannelAccountParaId);

    int insert(PaymentChannelAccountPara record);

    int insertSelective(PaymentChannelAccountPara record);

    PaymentChannelAccountPara selectByPrimaryKey(@Param("paymentChannelAccountParaId")Integer paymentChannelAccountParaId);

    int updateByPrimaryKeySelective(PaymentChannelAccountPara record);

    int updateByPrimaryKeyWithBLOBs(PaymentChannelAccountPara record);

    int updateByPrimaryKey(PaymentChannelAccountPara record);

	List<PaymentChannelAccountPara> selectByPaymentChannelAccountId(@Param("paymentChannelAccountId")Integer paymentChannelAccountId);
}