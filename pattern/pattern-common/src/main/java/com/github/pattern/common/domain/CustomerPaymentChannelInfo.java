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

	public Integer getCustomerPaymentChannelInfoId() {
		return customerPaymentChannelInfoId;
	}

	public void setCustomerPaymentChannelInfoId(Integer customerPaymentChannelInfoId) {
		this.customerPaymentChannelInfoId = customerPaymentChannelInfoId;
	}

	public Integer getPaymentChannelId() {
		return paymentChannelId;
	}

	public void setPaymentChannelId(Integer paymentChannelId) {
		this.paymentChannelId = paymentChannelId;
	}

	public Integer getCustomerId() {
		return customerId;
	}

	public void setCustomerId(Integer customerId) {
		this.customerId = customerId;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public Date getUpdateTtime() {
		return updateTtime;
	}

	public void setUpdateTtime(Date updateTtime) {
		this.updateTtime = updateTtime;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	
    
    
    
   
}