package com.github.pattern.common.domain;

import java.util.Date;

public class PaymentChannelAccount extends BaseObject {
	/**
	 * 
	 */
	private static final long serialVersionUID = 6423346397402232840L;
	/**
	 * 渠道账户ID
	 */
	private Integer paymentChannelAccountId;
	/**
	 * 支付渠道ID
	 */
	private Integer paymentChannelId;
	/**
	 * 账户名称
	 */
	private String accountName;

	/**
	 * 是否锁定 0否 1是
	 */
	private Integer status;
	
	private Date createTime;
	
	private Date updateTime;
	/**
	 * 备注
	 */
	private String remark;
	public Integer getPaymentChannelAccountId() {
		return paymentChannelAccountId;
	}
	public void setPaymentChannelAccountId(Integer paymentChannelAccountId) {
		this.paymentChannelAccountId = paymentChannelAccountId;
	}
	public Integer getPaymentChannelId() {
		return paymentChannelId;
	}
	public void setPaymentChannelId(Integer paymentChannelId) {
		this.paymentChannelId = paymentChannelId;
	}
	public String getAccountName() {
		return accountName;
	}
	public void setAccountName(String accountName) {
		this.accountName = accountName;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
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

	
   
	

	
}