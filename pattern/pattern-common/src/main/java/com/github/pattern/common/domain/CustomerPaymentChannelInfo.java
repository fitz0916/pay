package com.github.pattern.common.domain;

import java.util.Date;

/**
 * 商户支付通道实体类 
 */
public class CustomerPaymentChannelInfo extends BaseObject {

	
    /**
     * 商户支付通道ID
     */
    private Integer customerPaymentChannelInfoId;
    /***
     * 渠道ID
     */
    private Integer paymentChannelId;
   
    /**
     * 商户ID
     */
    private Integer customerId;
    
    private Date createTime;
    
    private Date updateTtime;
   
    /**
     * 备注
     */
    private String remark;

	
    
    
    
   
}