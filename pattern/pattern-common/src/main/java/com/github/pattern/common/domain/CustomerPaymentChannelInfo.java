package com.github.pattern.common.domain;

/**
 * 商户支付通道实体类 
 */
public class CustomerPaymentChannelInfo extends BaseObject {

    /**
     * 商户支付通道ID
     */
    private Integer paymentChannelInfoId;
    /***
     * 渠道ID
     */
    private Integer paymentChannelId;
    /**
     * 商户ID
     */
    private Integer customerId;
   
    /**
     * 优先级（从大到小）
     */
    private Integer priority;
    /**
     * 是否冻结
     */
    private Integer isFroze;
    /**
     * 备注
     */
    private String remark;

	
    
    
    
   
}