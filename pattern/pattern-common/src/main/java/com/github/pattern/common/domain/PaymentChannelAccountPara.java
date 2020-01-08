package com.github.pattern.common.domain;

import java.util.Date;

public class PaymentChannelAccountPara extends BaseObject {

	/**
	 * 
	 */
	private static final long serialVersionUID = -2344761665430915920L;

	/**
	 * 渠道账户参数ID
	 */
	private Integer paymentChannelAccountParaId;

	/**
	 * 渠道账户ID
	 */
	private Integer paymentChannelAccountId;
	/**
	 * 属性名
	 */
	private String name;
	
	/**
	 * 是否锁定 0：禁用 1：启用 2：删除
	 */
	private Integer status;
	
	/**
	 * 属性值
	 */
	private String value;

	private Date createTime;
	
	private Date updateTime;

	private String remark;

	public Integer getPaymentChannelAccountParaId() {
		return paymentChannelAccountParaId;
	}

	public void setPaymentChannelAccountParaId(Integer paymentChannelAccountParaId) {
		this.paymentChannelAccountParaId = paymentChannelAccountParaId;
	}

	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	
	public Integer getPaymentChannelAccountId() {
		return paymentChannelAccountId;
	}

	public void setPaymentChannelAccountId(Integer paymentChannelAccountId) {
		this.paymentChannelAccountId = paymentChannelAccountId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
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