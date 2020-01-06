package com.github.pattern.common.domain;

import java.util.Date;

/**
 * 商户支付白名单
 * 
 */
public class PaymentWhiteList extends BaseObject {

	private static final long serialVersionUID = -8459939368321454348L;

	/**
	 * pay_white_list_id 主键
	 */
	private Integer paymentWhiteListId;
	/**
	 * agent_id 商户ID
	 */
	private Integer customerId;
	/**
	 * 请求IP
	 */
	private String ip;
	/**
	 * status 状态，0未生效，1生效
	 */
	private Integer status;
	/**
	 * create_time 创建时间
	 */
	private Date createTime;
	/**
	 * remark 备注
	 */
	private String remark;
	

	

}