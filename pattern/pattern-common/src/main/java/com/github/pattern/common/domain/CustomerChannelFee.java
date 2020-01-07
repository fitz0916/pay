package com.github.pattern.common.domain;

import java.math.BigDecimal;
import java.util.Date;

public class CustomerChannelFee extends BaseObject{
	
	private Integer paymentChanneldFeeId;
	//渠道ID
	private Integer paymentChannelId;
	//介入三方费率
	private BigDecimal thirdRate;
	//销售费率
	private BigDecimal salesRate;
	
	/***
	 * 创建时间
	 */
	private Date createTime;
	/***
	 * 更新时间
	 */
	private Date updateTime;
	
	private String remark;
	
}
