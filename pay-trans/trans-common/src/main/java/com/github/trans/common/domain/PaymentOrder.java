package com.github.trans.common.domain;

import java.math.BigDecimal;
import java.util.Date;

public class PaymentOrder extends BaseObject{
	//订单号
	private String orderNo;
	//商户号
	private String customerNo;
	//商户名称
	private String customerName;
	//代理商ID
	private Integer agentId;
	//代理商名称
	private String agentName;
	//门店ID
	private Integer shopId;
	//门店名称
	private String shopName;
	//三方渠道号
	private String thirdCustomerNo;
	//商户订单号
	private String customerOrderNo;
	//三方支付费率
	private String thirdChannelOrderNo;
	//支付类型
	private String payType;
	//支付状态0:初始化1：支付进行中 2：支付成功 3：支付失败
	private int payStatus;
	//订单生成时间
	private Date transTime;
	//订单交易完成时间
	private Date transFinishTime;
	//主题
	private String subject;
	//描述
	private String desc;
	//商户渠道ID
	private Integer customerPaymentChannelInfoId;
	//渠道ID
	private Integer paymentChannelId;
	//渠道账号ID
	private Integer paymentChannelAccountId;
	//后台回调地址
	private String notifyUrl;
	//前端回调地址
	private String returnUrl;
	//交易金额
	private Long payAmount; 
	//三方渠道费率
	private BigDecimal thirdChannelFee;
	//三方渠道收取手续费（分）
	private Long thirdChannelProundage;
	//销售费率
	private BigDecimal saleFee;
	//收取商户手续费用(分)
	private Long saleProundage;
	//代理商费率
	private BigDecimal agent_fee;
	//代理商手续费(实际金额*在开通通道界面配置的费率)
	private Long agent_proundage;
	//商户实际到账金额(交易金额-交易金额*接入费率)
	private Long customer_amount;
	//二维码地址
	private String qrCode;
	//结算类型 700:T0结算 701:T1结算  702:D0  703:D1
	private String settlement_type;
	//结算状态0：未结算，1：已结算 2：结算失败
	private int settlement_status;
	
}
