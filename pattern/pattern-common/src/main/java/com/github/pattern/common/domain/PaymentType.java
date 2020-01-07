package com.github.pattern.common.domain;

import java.util.Date;

public class PaymentType extends BaseObject {

	/**
	 * 交易类型ID
	 */
	private Integer paymentTypeId;

	/**
	 * 支付模式：0:web ，1:app
	 */
	private Integer payModel;
	/**
	 * 交易类型名称
	 */
	private String paymentName;
	
	/***
	 * 创建时间
	 */
	private Date createTime;
	
	/***
	 * 更新时间
	 */
	private Date updateTime;
	/**
	 * 备注
	 */
	private String remark;

	

}