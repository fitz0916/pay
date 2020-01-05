package com.github.pattern.common.domain;

public class PayChannelInfoRisk extends BaseObject {

	/**
	 * 支付通道风控表ID
	 */
	private Integer payChannelInfoRiskId;

	/**
	 * 支付通道ID
	 */
	private Integer payChannelInfoId;

	/**
	 * 交易类型ID
	 */
	private Integer payTypeId;

	/**
	 * 允许支付时间(格式hh:mm:ss-hh:mm:ss 24小时制 多条用|隔开,不输入则不限制)
	 */
	private String allowTime;

	/**
	 * 交易次数限制(不输入则不限制)
	 */
	private Integer allowNum;

	/**
	 * 交易时间间隔(单位秒)
	 */
	private Integer payInterval;

	/**
	 * 单笔交易金额限制(单位分,格式50-1000 多条用|隔开,不输入则不限制)
	 */
	private String singleMoney;

	/**
	 * 交易日限额(单位元,不输入则不限制)
	 */
	private Integer dayMoney;

	/**
	 * 允许终端用户支付最多次数(不输入则不限制)
	 */
	private Integer userMostNumber;

	/**
	 * 备注
	 */
	private String remark;

	/**
	 * 联合查询对象
	 */
	private PayChannelInfo payChannelInfo;

	public Integer getPayChannelInfoRiskId() {
		return payChannelInfoRiskId;
	}

	public void setPayChannelInfoRiskId(Integer payChannelInfoRiskId) {
		this.payChannelInfoRiskId = payChannelInfoRiskId;
	}

	public Integer getPayChannelInfoId() {
		return payChannelInfoId;
	}

	public void setPayChannelInfoId(Integer payChannelInfoId) {
		this.payChannelInfoId = payChannelInfoId;
	}

	public Integer getPayTypeId() {
		return payTypeId;
	}

	public void setPayTypeId(Integer payTypeId) {
		this.payTypeId = payTypeId;
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

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Integer getUserMostNumber() {
		return userMostNumber;
	}

	public void setUserMostNumber(Integer userMostNumber) {
		this.userMostNumber = userMostNumber;
	}

	public PayChannelInfo getPayChannelInfo() {
		return payChannelInfo;
	}

	public void setPayChannelInfo(PayChannelInfo payChannelInfo) {
		this.payChannelInfo = payChannelInfo;
	}

	@Override
	public String toString() {
		return "PayChannelInfoRisk{" + "payChannelInfoRiskId=" + payChannelInfoRiskId + ", payChannelInfoId="
				+ payChannelInfoId + ", payTypeId=" + payTypeId + ", allowTime='" + allowTime + '\'' + ", allowNum="
				+ allowNum + ", payInterval=" + payInterval + ", singleMoney='" + singleMoney + '\'' + ", dayMoney="
				+ dayMoney + ", remark='" + remark + '\'' + ", userMostNumber=" + userMostNumber + '}';
	}
}