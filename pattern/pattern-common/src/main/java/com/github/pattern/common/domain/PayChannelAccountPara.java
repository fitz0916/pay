package com.github.pattern.common.domain;

public class PayChannelAccountPara extends BaseObject {

	/**
	 * 渠道账户参数ID
	 */
	private Integer payChannelAccountParaId;

	/**
	 * 渠道账户ID
	 */
	private Integer payChannelAccountId;

	/**
	 * 支付渠道参数ID
	 */
	private Integer payChannelParaId;

	/**
	 * 属性名
	 */
	private String name;

	/**
	 * 属性值
	 */
	private String value;

	/**
	 * 所属渠道账户参数
	 */
	private PayChannelPara payChannelPara;

	public Integer getPayChannelAccountParaId() {
		return payChannelAccountParaId;
	}

	public void setPayChannelAccountParaId(Integer payChannelAccountParaId) {
		this.payChannelAccountParaId = payChannelAccountParaId;
	}

	public Integer getPayChannelAccountId() {
		return payChannelAccountId;
	}

	public void setPayChannelAccountId(Integer payChannelAccountId) {
		this.payChannelAccountId = payChannelAccountId;
	}

	public Integer getPayChannelParaId() {
		return payChannelParaId;
	}

	public void setPayChannelParaId(Integer payChannelParaId) {
		this.payChannelParaId = payChannelParaId;
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

	public PayChannelPara getPayChannelPara() {
		return payChannelPara;
	}

	public void setPayChannelPara(PayChannelPara payChannelPara) {
		this.payChannelPara = payChannelPara;
	}

	
}