package com.github.pattern.common.domain;

import java.util.Date;

/**
 * 商户支付通道实体类 
 */
public class CustomerPaymentChannelInfo extends BaseObject {

	
    /**
	 * 
	 */
	private static final long serialVersionUID = 405598671940767465L;
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
	 * 支付状态（0禁用 1启用 2删除）
	 **/
	private Integer status;
	
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

	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
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