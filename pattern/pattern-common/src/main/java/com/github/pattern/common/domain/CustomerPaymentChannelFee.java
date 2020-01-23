package com.github.pattern.common.domain;

import java.util.Date;

public class CustomerPaymentChannelFee extends BaseObject{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 777976886412887024L;
	
	private Integer paymentChanneldFeeId;
	//渠道ID
	private Integer paymentChannelId;
	//介入三方费率
	private String thirdRate;
	//销售费率
	private String salesRate;
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

	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	
	public Integer getPaymentChannelId() {
		return paymentChannelId;
	}

	public void setPaymentChannelId(Integer paymentChannelId) {
		this.paymentChannelId = paymentChannelId;
	}

	public String getThirdRate() {
		return thirdRate;
	}

	public void setThirdRate(String thirdRate) {
		this.thirdRate = thirdRate;
	}

	public String getSalesRate() {
		return salesRate;
	}

	public void setSalesRate(String salesRate) {
		this.salesRate = salesRate;
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
