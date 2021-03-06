package com.github.pattern.common.domain;

import java.math.BigDecimal;
import java.util.Date;

public class CustomerPaymentChannelFee extends BaseObject{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 777976886412887024L;
	
	private Integer paymentChanneldFeeId;
	//商户ID
	private Integer customerId;
	//渠道ID
	private Integer paymentChannelId;
	//介入三方费率
	private  BigDecimal thirdRate;
	//销售费率
	private BigDecimal customerRate;
	//代理商费率
	private BigDecimal agentRate;
	//门店费率
	private BigDecimal shopRate;
	/***
	 * 创建时间
	 */
	private Date createTime;
	/***
	 * 更新时间
	 */
	private Date updateTime;
	
	/** 支付状态（0启用 1禁用 2删除）*/
	private Integer status;
	
	private String remark;

	public Integer getPaymentChanneldFeeId() {
		return paymentChanneldFeeId;
	}

	public void setPaymentChanneldFeeId(Integer paymentChanneldFeeId) {
		this.paymentChanneldFeeId = paymentChanneldFeeId;
	}
	
	public BigDecimal getAgentRate() {
		return agentRate;
	}

	public void setAgentRate(BigDecimal agentRate) {
		this.agentRate = agentRate;
	}

	public BigDecimal getShopRate() {
		return shopRate;
	}

	public void setShopRate(BigDecimal shopRate) {
		this.shopRate = shopRate;
	}

	public Integer getCustomerId() {
		return customerId;
	}

	public void setCustomerId(Integer customerId) {
		this.customerId = customerId;
	}

	public Integer getPaymentChannelId() {
		return paymentChannelId;
	}

	public void setPaymentChannelId(Integer paymentChannelId) {
		this.paymentChannelId = paymentChannelId;
	}

	public BigDecimal getThirdRate() {
		return thirdRate;
	}

	public void setThirdRate(BigDecimal thirdRate) {
		this.thirdRate = thirdRate;
	}

	public BigDecimal getCustomerRate() {
		return customerRate;
	}

	public void setCustomerRate(BigDecimal customerRate) {
		this.customerRate = customerRate;
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

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	
}
