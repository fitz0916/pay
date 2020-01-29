package com.github.channel.common.response;

import com.github.channel.common.domain.ChannelResponse;

public class PayJsResponse extends ChannelResponse{
	
	private String return_code;
	//返回消息
	private String return_msg;
	//PAYJS 平台订单号
	private String payjs_order_id;
	//用户生成的订单号原样返回
	private String out_trade_no;	
	//金额。单位：分
	private int total_fee;
	//二维码图片地址
	private String qrcode;	
	//可将该参数生成二维码展示出来进行扫码支付(有效期2小时)
	private String code_url;	
	//数据签名 详见签名算法
	private String sign;	
}
