package com.github.channel.common.request;

import com.github.channel.common.domain.ChannelRequest;

public class PayJsRequest extends ChannelRequest{

	//商户号
	private String mchid;
	//交易金额（分）
	private int total_fee;
	//用户端自主生成的订单号
	private String out_trade_no;
	//订单标题
	private String body;
	//用户自定义数据，在notify的时候会原样返回
	private String attach;
	//接收微信支付异步通知的回调地址。必须为可直接访问的URL，不能带参数、session验证、csrf验证。留空则不通知
	private String notify_url;
	//数据签名
	private String sign;
	//请求地址
	private String url;
}
