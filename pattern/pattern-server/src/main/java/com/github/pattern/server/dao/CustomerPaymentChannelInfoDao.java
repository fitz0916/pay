package com.github.pattern.server.dao;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.github.pattern.common.domain.CustomerPaymentChannelInfo;

@Repository
public interface CustomerPaymentChannelInfoDao {
	
    int deleteByPrimaryKey(@Param("customerPaymentChannelInfoId")Integer customerPaymentChannelInfoId);

    int insert(CustomerPaymentChannelInfo record);

    int insertSelective(CustomerPaymentChannelInfo record);

    CustomerPaymentChannelInfo selectByPrimaryKey(@Param("customerPaymentChannelInfoId")Integer customerPaymentChannelInfoId);

    int updateByPrimaryKeySelective(CustomerPaymentChannelInfo record);

    int updateByPrimaryKey(CustomerPaymentChannelInfo record);
}