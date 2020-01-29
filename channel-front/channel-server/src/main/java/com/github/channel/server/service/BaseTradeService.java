package com.github.channel.server.service;

import java.util.Map;

import com.alibaba.fastjson.JSONObject;
import com.github.appmodel.domain.result.ModelResult;
import com.github.channel.common.domain.ChannelRequest;
import com.github.channel.common.domain.ChannelResponse;

public abstract class BaseTradeService<R extends ChannelRequest,Q extends ChannelResponse> {

	/***
	 * 获取请求渠道地址
	 * @param req
	 * @return
	 */
	protected abstract ModelResult<String> getRequestUrl(R req);
	
	
	 /**
     * 请求参数检查,默认不做任何检查
     * @param req 交易请求
     *            
     */
    protected abstract void check(Q req);

    /**
     * 打包请求报文字符串或者xml格式格式
     * @param req   交易请求
     * @return
     */
    protected abstract String packStr(Q req);

    
    /**
     * 打包请求报文map格式
     * @param req   交易请求
     * @return
     */
    protected abstract Map<String,String> packMap(Q req);

    /**
     * 打包json对象
     * @param req
     * @return
     */
    protected abstract JSONObject packJson(Q req);

    /**
     * 解包响应报文
     * @param respStr  响应报文xml
     * @return
     */
    protected abstract P parse(Q req,String respStr);
}
