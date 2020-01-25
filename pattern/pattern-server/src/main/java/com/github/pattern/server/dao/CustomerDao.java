package com.github.pattern.server.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.github.pattern.common.domain.Customer;

@Repository
public interface CustomerDao {
	
	
    int deleteByPrimaryKey(@Param("customerId")Integer customerId);

    int insert(Customer record);

    int insertSelective(Customer record);

    Customer selectByPrimaryKey(@Param("customerId")Integer customerId);

    Customer selectByCustomerName(@Param("customerName")String customerName);
    
    int updateByPrimaryKeySelective(Customer record);

    int updateByPrimaryKey(Customer record);

	long pageCount(@Param("statusList")List<Integer> statusList,@Param("shopId") Integer shopId);

	List<Customer> pageList(@Param("start")int start, @Param("offset")int offset, @Param("statusList")List<Integer> statusList,@Param("shopId") Integer shopId);

	Customer selectByCustomerNo(@Param("customerNo")String customerNo);
}