package com.github.pattern.common.domain;

public class PayChannel extends BaseObject {

	/**
	 * 支付渠道ID
	 */
	private Integer payChannelId;

	/**
	 * 渠道简称
	 */
	private String channelName;

	/**
	 * 渠道模板英文名
	 */
	private String templateName;

	/**
	 * 渠道全称
	 */
	private String fullName;

	/**
	 * 备注
	 */
	private String remark;


	public Integer getPayChannelId() {
		return payChannelId;
	}

	public void setPayChannelId(Integer payChannelId) {
		this.payChannelId = payChannelId;
	}

	public String getChannelName() {
		return channelName;
	}

	public void setChannelName(String channelName) {
		this.channelName = channelName;
	}

	public String getTemplateName() {
		return templateName;
	}

	public void setTemplateName(String templateName) {
		this.templateName = templateName;
	}

	public String getFullName() {
		return fullName;
	}

	public void setFullName(String fullName) {
		this.fullName = fullName;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	
}