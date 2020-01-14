package com.github.pattern.server.dao;

import java.util.List;

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
    
    long selectPaymentChannelInfoByCustomerId(@Param("customerId")Integer customerId);

	List<CustomerPaymentChannelInfo> pageList(@Param("start")int start, @Param("offset")int offset, @Param("customerId")Integer customerId);
	
	
	CustomerPaymentChannelInfo selectByCustomerIdAndPaymentChannelId(@Param("customerId")Integer customerId,@Param("paymentChannelId")Integer paymentChannelId);
}