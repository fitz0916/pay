package com.github.pattern.common.domain;

import java.util.Date;

public class PaymentBlackList extends BaseObject{
	
	private Integer paymentBlackListId;
	
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
