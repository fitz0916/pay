package com.github.pattern.common.domain;

import java.util.Date;
import java.util.List;

public class PaymentChannelAccount extends BaseObject {
	/**
	 * 渠道账户ID
	 */
	private Integer paymentChannelAccountId;
	/**
	 * 支付渠道ID
	 */
	private Integer paymentChannelId;
	/**
	 * 账户名称
	 */
	private String accountName;

	/**
	 * 是否锁定 0否 1是
	 */
	private Integer status;
	
	/**
	 * 备注
	 */
	private String remark;

	

	

	
}