package com.github.channel.server.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.github.appmodel.domain.result.ModelResult;
import com.github.channel.common.domain.ChannelRequest;
import com.github.channel.common.domain.ChannelResponse;

import okhttp3.MediaType;

public abstract class BaseTradeService<R extends ChannelRequest,Q extends ChannelResponse> {
	
	private final static Logger LOGGER = LoggerFactory.getLogger(BaseTradeService.class);
	protected final MediaType MediaTypeJson = MediaType.parse("application/json; charset=utf-8");
	 /**
     * 连接超时时间
     */
	protected long connectTimeout = 3000L;

    /**
     * 读取超时时间
     */
    protected long readTimeout = 5000L;
	
	protected ModelResult<Q> process(R request){
		ModelResult<Q> modelResult = new ModelResult<Q>();
		ModelResult<String> checkModelResult = this.checkParamter(request);
		if(!checkModelResult.isSuccess()) {
			String errorCode = checkModelResult.getErrorCode();
			String errorMsg = checkModelResult.getErrorMsg();
			LOGGER.error("请求对象参数验证errorCode = 【{}】,errorMsg = 【{}】",errorCode,errorMsg);
			modelResult.withError(errorCode, errorMsg);
			return modelResult;
		}
	    modelResult = this.processWithJson(request);
		return modelResult;
		
		
	}
	
	 /**
     * 请求参数检查,默认不做任何检查
     * @param req 交易请求
     *            
     */
    protected abstract ModelResult<String> checkParamter(R request);

    /**
     * 打包json对象
     * @param req
     * @return
     */
    protected abstract ModelResult<Q> processWithJson(R request);

    /**
     * 解包响应报文
     * @param respStr  响应报文xml
     * @return
     */
    protected abstract ModelResult<Q> parse(R request,String respStr);
}
