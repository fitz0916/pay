package com.github.pattern.common.domain;

import java.util.Date;

/***
 * 支付渠道
 *
 */
public class PaymentChannel extends BaseObject {
	/**
	 * 支付渠道ID
	 */
	private Integer paymentChannelId;
	/**
	 * 渠道简称
	 */
	private String channelName;
	/**
	 * 对接三方支付名称
	 * 
	 **/
	private String thirdChannelName;
	
	//结算方式
	private Integer settlementType;
		
	/***
	 * 渠道状态0：停用 1：启用
	 */
	private Integer status;

	/**
	 * 支付类型
	 */
	private Integer payType;
	/**
	 * 渠道创建时间
	 */
	private Date createTime;
	/**
	 * 渠道更新时间
	 */
	private Date updateTime;
	
	/**
	 * 商务联系人
	 */
	private String businessContacts;

	/**
	 * QQ
	 */
	private String qq;

	/**
	 * 微信
	 */
	private String wechat;

	/**
	 * 商务联系人手机号码
	 */
	private String mobile;
	
	/**
	 * 备注
	 */
	private String remark;
	
	
}