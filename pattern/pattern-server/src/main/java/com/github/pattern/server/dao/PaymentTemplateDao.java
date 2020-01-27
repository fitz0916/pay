package com.github.pattern.server.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.github.pattern.common.domain.PaymentTemplate;

@Repository
public interface PaymentTemplateDao {
	
    int deleteByPrimaryKey(@Param("paymentTemplateId")Integer paymentTemplateId);

    int insert(PaymentTemplate record);

    int insertSelective(PaymentTemplate record);

    PaymentTemplate selectByPrimaryKey(@Param("paymentTemplateId")Integer paymentTemplateId);

    int updateByPrimaryKeySelective(PaymentTemplate record);

    int updateByPrimaryKey(PaymentTemplate record);

	List<PaymentTemplate> selectByPayType(@Param("payType")String payType);
}