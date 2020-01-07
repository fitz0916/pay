package com.github.pattern.common.domain;

import java.util.Date;

public class PaymentChannelRisk extends BaseObject {
	/**
	 * 支付通道风控表ID
	 */
	private Integer paymentChannelInfoRiskId;
	/**
	 * 支付通道ID
	 */
	private Integer paymentChannelId;
	/**
	 * 允许支付时间(格式hh:mm:ss-hh:mm:ss 24小时制 多条用|隔开,不输入则不限制)
	 */
	private String allowTime;
	/**
	 * 交易次数限制，默认值-1
	 */
	private Integer allowNum;
	/**
	 * 交易时间间隔，默认值-1
	 */
	private Integer payInterval;
	/**
	 * 单笔交易金额限制(单位分,格式50-1000 多条用|隔开,不输入则不限制)
	 */
	private String singleMoney;
	/**
	 * 交易日限额，默认值-1
	 */
	private Integer dayMoney;
	/**
	 * 允许终端用户支付最多次数，默认值-1
	 */
	private Integer userMostNumber;
	/**
     * 使用策略 0随机 1优先级 2权重
     */
	private Integer strategy;
	/***
	 * 单比交易最小金额，默认值-1
	 */
	private Integer minMoney;
	/***
	 * 单比交易最打金额，默认值-1
	 */
	private Integer maxMoney;
	 /**
     * 是否冻结0冻结 1，正常
     */
    private Integer isFroze;
    
    private Date createTime;
    
    private Date updateTime;
	/**
	 * 备注
	 */
	private String remark;
	public Integer getPaymentChannelInfoRiskId() {
		return paymentChannelInfoRiskId;
	}
	public void setPaymentChannelInfoRiskId(Integer paymentChannelInfoRiskId) {
		this.paymentChannelInfoRiskId = paymentChannelInfoRiskId;
	}
	public Integer getPaymentChannelId() {
		return paymentChannelId;
	}
	public void setPaymentChannelId(Integer paymentChannelId) {
		this.paymentChannelId = paymentChannelId;
	}
	public String getAllowTime() {
		return allowTime;
	}
	public void setAllowTime(String allowTime) {
		this.allowTime = allowTime;
	}
	public Integer getAllowNum() {
		return allowNum;
	}
	public void setAllowNum(Integer allowNum) {
		this.allowNum = allowNum;
	}
	public Integer getPayInterval() {
		return payInterval;
	}
	public void setPayInterval(Integer payInterval) {
		this.payInterval = payInterval;
	}
	public String getSingleMoney() {
		return singleMoney;
	}
	public void setSingleMoney(String singleMoney) {
		this.singleMoney = singleMoney;
	}
	public Integer getDayMoney() {
		return dayMoney;
	}
	public void setDayMoney(Integer dayMoney) {
		this.dayMoney = dayMoney;
	}
	public Integer getUserMostNumber() {
		return userMostNumber;
	}
	public void setUserMostNumber(Integer userMostNumber) {
		this.userMostNumber = userMostNumber;
	}
	public Integer getStrategy() {
		return strategy;
	}
	public void setStrategy(Integer strategy) {
		this.strategy = strategy;
	}
	public Integer getMinMoney() {
		return minMoney;
	}
	public void setMinMoney(Integer minMoney) {
		this.minMoney = minMoney;
	}
	public Integer getMaxMoney() {
		return maxMoney;
	}
	public void setMaxMoney(Integer maxMoney) {
		this.maxMoney = maxMoney;
	}
	public Integer getIsFroze() {
		return isFroze;
	}
	public void setIsFroze(Integer isFroze) {
		this.isFroze = isFroze;
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