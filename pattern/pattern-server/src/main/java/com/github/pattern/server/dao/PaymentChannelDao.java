package com.github.pattern.server.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.github.pattern.common.domain.PaymentChannel;

@Repository
public interface PaymentChannelDao {
	
	
    int deleteByPrimaryKey(@Param("payChannelId")Integer payChannelId);

    int insert(PaymentChannel record);

    int insertSelective(PaymentChannel record);

    PaymentChannel selectByPrimaryKey(@Param("payChannelId")Integer payChannelId);

    int updateByPrimaryKeySelective(PaymentChannel record);

    int updateByPrimaryKey(PaymentChannel record);

	long pageCount();

	List<PaymentChannel> pageList(@Param("start")int start, @Param("offset")int offset);
}