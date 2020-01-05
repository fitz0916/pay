package com.github.pattern.common.domain;

public class PayChannelPara extends BaseObject {

	/**
	 * 渠道参数ID
	 */
	private Integer payChannelParaId;

	/**
	 * 参数中文描述
	 */
	private String chName;

	/**
	 * 参数名称（英文）
	 */
	private String enName;

	/**
	 * 备注
	 */
	private String remark;

	/**
	 * 支付渠道ID
	 */
	private Integer payChannelId;

	public Integer getPayChannelParaId() {
		return payChannelParaId;
	}

	public void setPayChannelParaId(Integer payChannelParaId) {
		this.payChannelParaId = payChannelParaId;
	}

	public Integer getPayChannelId() {
		return payChannelId;
	}

	public void setPayChannelId(Integer payChannelId) {
		this.payChannelId = payChannelId;
	}

	public String getChName() {
		return chName;
	}

	public void setChName(String chName) {
		this.chName = chName;
	}

	public String getEnName() {
		return enName;
	}

	public void setEnName(String enName) {
		this.enName = enName;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

}