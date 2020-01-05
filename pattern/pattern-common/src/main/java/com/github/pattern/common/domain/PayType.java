package com.github.pattern.common.domain;

public class PayType extends BaseObject {

	/**
	 * 交易类型ID
	 */
	private Integer payTypeId;

	/**
	 * 交易类型名称
	 */
	private String payname;

	/**
	 * 备注
	 */
	private String remark;

	public Integer getPayTypeId() {
		return payTypeId;
	}

	public void setPayTypeId(Integer payTypeId) {
		this.payTypeId = payTypeId;
	}

	public String getPayname() {
		return payname;
	}

	public void setPayname(String payname) {
		this.payname = payname;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

}