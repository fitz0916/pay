package com.github.pattern.common.domain;

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

	
	
}