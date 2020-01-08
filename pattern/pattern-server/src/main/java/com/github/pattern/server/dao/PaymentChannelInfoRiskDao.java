package com.github.pattern.server.dao;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.github.pattern.common.domain.PaymentChannelInfoRisk;


@Repository
public interface PaymentChannelInfoRiskDao {
	
	
    int deleteByPrimaryKey(@Param("paymentChannelinfoRiskId")Integer paymentChannelinfoRiskId);

    int insert(PaymentChannelInfoRisk record);

    int insertSelective(PaymentChannelInfoRisk record);

    PaymentChannelInfoRisk selectByPrimaryKey(@Param("paymentChannelinfoRiskId")Integer paymentChannelinfoRiskId);

    int updateByPrimaryKeySelective(PaymentChannelInfoRisk record);

    int updateByPrimaryKey(PaymentChannelInfoRisk record);
}