package com.github.pattern.common.domain;

import java.math.BigDecimal;
import java.util.Date;

/**
 * 支付通道实体类 
 */
public class PayChannelInfo extends BaseObject {

	/**
	 * 支付通道ID
	 */
	private Integer payChannelInfoId;

	/**
	 * 支付渠道ID
	 */
	private Integer payChannelId;

	/**
	 * 渠道账户ID
	 */
	private Integer payChannelAccountId;

	/**
	 * 支付通道名称
	 */
	private String channelInfoName;

	/**
	 * 是否锁定 0否1是
	 */
	private Integer isLock;

	/**
	 * 备注
	 */
	private String remark;

	/**
	 * 接入第三方的费率
	 */
	private BigDecimal fee;

	/**
	 * 销售费率
	 */
	private BigDecimal salefee;

	/**
	 * 所开通的交易类型ID
	 */
	private Integer payTypeId;


	/**
	 * 交易类型（临时字段，不存入数据库）
	 */
	private PayType payType;

	/**
	 * 支付通道创建时间
	 */
	private Date createTime;

	/**
	 * 渠道账户（临时字段，不存入数据库）
	 */
	private PayChannelAccount payChannelAccount;

	public Integer getPayChannelInfoId() {
		return payChannelInfoId;
	}

	public void setPayChannelInfoId(Integer payChannelInfoId) {
		this.payChannelInfoId = payChannelInfoId;
	}

	public Integer getPayChannelId() {
		return payChannelId;
	}

	public void setPayChannelId(Integer payChannelId) {
		this.payChannelId = payChannelId;
	}

	public Integer getPayChannelAccountId() {
		return payChannelAccountId;
	}

	public void setPayChannelAccountId(Integer payChannelAccountId) {
		this.payChannelAccountId = payChannelAccountId;
	}

	public String getChannelInfoName() {
		return channelInfoName;
	}

	public void setChannelInfoName(String channelInfoName) {
		this.channelInfoName = channelInfoName;
	}

	public Integer getIsLock() {
		return isLock;
	}

	public void setIsLock(Integer isLock) {
		this.isLock = isLock;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public BigDecimal getFee() {
		return fee;
	}

	public void setFee(BigDecimal fee) {
		this.fee = fee;
	}

	public BigDecimal getSalefee() {
		return salefee;
	}

	public void setSalefee(BigDecimal salefee) {
		this.salefee = salefee;
	}

	public Integer getPayTypeId() {
		return payTypeId;
	}

	public void setPayTypeId(Integer payTypeId) {
		this.payTypeId = payTypeId;
	}


	public PayType getPayType() {
		return payType;
	}

	public void setPayType(PayType payType) {
		this.payType = payType;
	}

	public PayChannelAccount getPayChannelAccount() {
		return payChannelAccount;
	}

	public void setPayChannelAccount(PayChannelAccount payChannelAccount) {
		this.payChannelAccount = payChannelAccount;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
}