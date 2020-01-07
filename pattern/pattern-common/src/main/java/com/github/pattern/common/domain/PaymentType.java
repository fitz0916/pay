package com.github.pattern.common.domain;

import java.util.Date;

public class PaymentType extends BaseObject {

	/**
	 * 交易类型ID
	 */
	private Integer paymentTypeId;

	/**
	 * 支付模式：0:web ，1:app
	 */
	private Integer payModel;
	/**
	 * 交易类型名称
	 */
	private String paymentName;
	
	/***
	 * 创建时间
	 */
	private Date createTime;
	
	/***
	 * 更新时间
	 */
	private Date updateTime;
	/**
	 * 备注
	 */
	private String remark;
	public Integer getPaymentTypeId() {
		return paymentTypeId;
	}
	public void setPaymentTypeId(Integer paymentTypeId) {
		this.paymentTypeId = paymentTypeId;
	}
	public Integer getPayModel() {
		return payModel;
	}
	public void setPayModel(Integer payModel) {
		this.payModel = payModel;
	}
	public String getPaymentName() {
		return paymentName;
	}
	public void setPaymentName(String paymentName) {
		this.paymentName = paymentName;
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