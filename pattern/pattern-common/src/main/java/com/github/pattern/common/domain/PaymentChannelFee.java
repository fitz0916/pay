package com.github.pattern.common.domain;

import java.math.BigDecimal;
import java.util.Date;

public class PaymentChannelFee extends BaseObject{
	
	private Integer paymentChanneldFeeId;
	//渠道ID
	private Integer paymentChannelId;
	//渠道名称
	private String channelName;
	//介入三方费率
	private BigDecimal thirdFee;
	//销售费率
	private BigDecimal sakeFee;
	
	private String remark;
	
}
