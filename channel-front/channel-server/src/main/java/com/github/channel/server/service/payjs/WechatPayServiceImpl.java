package com.github.channel.server.service.payjs;

import java.util.List;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.github.appmodel.domain.result.ModelResult;
import com.github.channel.common.constants.ChannelConstants;
import com.github.channel.common.request.payjs.WechatPayRequest;
import com.github.channel.common.request.payjs.WechatPaySignRequest;
import com.github.channel.common.response.payjs.WechatPayResponse;
import com.github.channel.common.service.payjs.WechatPayService;
import com.github.channel.common.utils.BeanValidatorUtils;
import com.github.channel.common.utils.OkHttpUtil;
import com.github.channel.common.utils.PayJsSignUtils;
import com.github.channel.server.service.BaseTradeService;
@Service
public class WechatPayServiceImpl extends BaseTradeService<WechatPayRequest, WechatPayResponse> implements WechatPayService<WechatPayRequest, WechatPayResponse>{

	private final static Logger LOGGER = LoggerFactory.getLogger(WechatPayServiceImpl.class);
	
	@Override
	public ModelResult<WechatPayResponse> pay(WechatPayRequest request) {
		LOGGER.info("用户请求对象数据 WechatPayRequest = 【{}】",request);
		ModelResult<WechatPayResponse> modelResult = this.process(request);
		return modelResult;
	}

	

	@Override
	protected ModelResult<String> checkParamter(WechatPayRequest request) {
		ModelResult<String> modelResult = new ModelResult<String>();
		if(request == null) {
			LOGGER.error("请求对象为空！");
			modelResult.withError("0", "非法请求数据");
			return modelResult;
		}
		List<String> list = BeanValidatorUtils.validateParam(request);
		if(CollectionUtils.isNotEmpty(list)) {
			String errorMsg = list.toString();
			LOGGER.warn("支付请求参数包含以下属性数据为空,errorMsg = 【{}】",errorMsg);
			modelResult.withError("0", errorMsg);
			return modelResult;
		}
		return modelResult;
	}

	@Override
	protected ModelResult<WechatPayResponse> processWithJson(WechatPayRequest request) {
		ModelResult<WechatPayResponse> modelResult = new ModelResult<WechatPayResponse>();
		try {
			WechatPaySignRequest payJsSignRequest = getSign(request);
			String sign = PayJsSignUtils.getSign(payJsSignRequest,request.getSecretKey());
			request.setSign(sign);
			String url = request.getUrl() + ChannelConstants.PAYJS_PAY_SUFFIX;
			JSONObject requestJSON = this.initJSONObject(request);
			String result = null;
		    result = OkHttpUtil.getInstance().postWithJson(url, requestJSON);
		    LOGGER.info("******payJs请求结果************* result = 【{}】",result);
			modelResult = parse(request, result);
		}catch(Exception e) {
			LOGGER.error("payJS支付请求失败,errorMsg = 【{}】",e.getMessage());
			modelResult.withError("0", "支付请求失败");
			return modelResult;
		}
		return modelResult;
	}
	
	
	private WechatPaySignRequest getSign(WechatPayRequest request) {
		WechatPaySignRequest payJsSignRequest = new WechatPaySignRequest();
		payJsSignRequest.setMchid(request.getMchid());
		payJsSignRequest.setOutTradeNo(request.getOutTradeNo());
		payJsSignRequest.setTotalFee(request.getTotalFee());
		payJsSignRequest.setAttach(request.getAttach());
		payJsSignRequest.setBody(request.getBody());
		payJsSignRequest.setNotifyUrl(request.getNotifyUrl());
		return payJsSignRequest;
	}
	private JSONObject initJSONObject(WechatPayRequest request) {
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("mchid", request.getMchid());
		jsonObject.put("total_fee", request.getTotalFee());
		jsonObject.put("out_trade_no", request.getOutTradeNo());
		jsonObject.put("body", request.getBody());
		jsonObject.put("attach", request.getAttach());
		jsonObject.put("notify_url", request.getNotifyUrl());
		jsonObject.put("sign", request.getSign());
		return jsonObject;
	}

	@Override
	protected ModelResult<WechatPayResponse> parse(WechatPayRequest request, String respStr) {
		ModelResult<WechatPayResponse> modelResult = new ModelResult<WechatPayResponse>();
		if(StringUtils.isBlank(respStr)) {
			modelResult.withError("0", "payJs微信扫支付解析请求结果失败");
			return modelResult;
		}
		WechatPayResponse response = JSON.parseObject(respStr,WechatPayResponse.class);
		String returnCode = response.getReturnCode();
		String returnMsg = response.getReturnMsg();
		if(returnCode.equals("0")) {
			modelResult.withError(returnCode, returnMsg);
			return modelResult;
		}
		modelResult.setModel(response);
		return modelResult;
	}

}
