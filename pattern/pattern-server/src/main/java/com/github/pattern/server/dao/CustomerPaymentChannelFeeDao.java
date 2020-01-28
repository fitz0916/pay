package com.github.pattern.server.dao;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.github.pattern.common.domain.CustomerPaymentChannelFee;

@Repository
public interface CustomerPaymentChannelFeeDao {
	
	
    int deleteByPrimaryKey(@Param("paymentChanneldFeeId")Integer paymentChanneldFeeId);

    int insert(CustomerPaymentChannelFee record);

    int insertSelective(CustomerPaymentChannelFee record);

    CustomerPaymentChannelFee selectByPrimaryKey(@Param("paymentChanneldFeeId")Integer paymentChanneldFeeId);

    int updateByPrimaryKeySelective(CustomerPaymentChannelFee record);

    int updateByPrimaryKey(CustomerPaymentChannelFee record);
    
    CustomerPaymentChannelFee selectByCustomerIdAndPaymentChannelId(@Param("customerId")Integer customerId,@Param("paymentChannelId")Integer paymentChannelId);
}