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
    
    private String customerNo;
    //结算方式：0:D0,1:D1,2:T0,3:T1
    private Integer settlementType;
    /**
     * 商户ID
     */
    private Integer customerId;
    
    private Date createTime;
    
    private Date updateTime;

	/**
	 * 支付状态（0禁用 1启用 2删除）
	 **/
	private Integer status;
	
    /**
     * 备注
     */
    private String remark;
    
    private PaymentChannel paymentChannel;

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
	
	public String getCustomerNo() {
		return customerNo;
	}

	public void setCustomerNo(String customerNo) {
		this.customerNo = customerNo;
	}

	public Integer getSettlementType() {
		return settlementType;
	}

	public void setSettlementType(Integer settlementType) {
		this.settlementType = settlementType;
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

	public Date getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public PaymentChannel getPaymentChannel() {
		return paymentChannel;
	}

	public void setPaymentChannel(PaymentChannel paymentChannel) {
		this.paymentChannel = paymentChannel;
	}

    
    
    
   
}