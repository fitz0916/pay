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
import com.github.channel.common.request.payjs.WechatPayQueryRequest;
import com.github.channel.common.request.payjs.WechatPayQuerySignRequest;
import com.github.channel.common.response.payjs.WechatPayQueryResponse;
import com.github.channel.common.service.payjs.WechatPayQueryService;
import com.github.channel.common.utils.BeanValidatorUtils;
import com.github.channel.common.utils.OkHttpUtil;
import com.github.channel.common.utils.PayJsSignUtils;
import com.github.channel.server.service.BaseTradeService;

@Service
public class WechatPayQueryServiceImpl extends BaseTradeService<WechatPayQueryRequest, WechatPayQueryResponse> implements WechatPayQueryService<WechatPayQueryRequest, WechatPayQueryResponse>{

	private final static Logger LOGGER = LoggerFactory.getLogger(WechatPayQueryServiceImpl.class);
	
	@Override
	public ModelResult<WechatPayQueryResponse> query(WechatPayQueryRequest request) {
		LOGGER.info("用户请求对象数据 WechatPayRequest = 【{}】",request);
		ModelResult<WechatPayQueryResponse> modelResult = this.process(request);
		return modelResult;
	}

	@Override
	protected ModelResult<String> checkParamter(WechatPayQueryRequest request) {
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
	protected ModelResult<WechatPayQueryResponse> processWithJson(WechatPayQueryRequest request) {
		ModelResult<WechatPayQueryResponse> modelResult = new ModelResult<WechatPayQueryResponse>();
		try {
			WechatPayQuerySignRequest payJsSignRequest = getSign(request);
			String sign = PayJsSignUtils.getSign(payJsSignRequest,request.getSecretKey());
			request.setSign(sign);
			String url = request.getUrl();
			JSONObject requestJSON = this.initJSONObject(request);
			String result = null;
		    result = OkHttpUtil.getInstance().postWithJson(url, requestJSON);
		    LOGGER.info("******payJs查询请求结果************* result = 【{}】",result);
			modelResult = parse(request, result);
		}catch(Exception e) {
			LOGGER.error("payJS支付查询请求失败,errorMsg = 【{}】",e.getMessage());
			modelResult.withError("0", "支付请求失败");
			return modelResult;
		}
		return modelResult;
	}

	private JSONObject initJSONObject(WechatPayQueryRequest request) {
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("payjs_order_id", request.getOutTradeNo());
		jsonObject.put("sign", request.getSign());
		return jsonObject;
	}

	private WechatPayQuerySignRequest getSign(WechatPayQueryRequest request) {
		WechatPayQuerySignRequest wechatPayQuerySignRequest = new WechatPayQuerySignRequest();
		wechatPayQuerySignRequest.setPayjsOrderId(request.getOutTradeNo());
		return wechatPayQuerySignRequest;
	}

	@Override
	protected ModelResult<WechatPayQueryResponse> parse(WechatPayQueryRequest request, String respStr) {
		ModelResult<WechatPayQueryResponse> modelResult = new ModelResult<WechatPayQueryResponse>();
		if(StringUtils.isBlank(respStr)) {
			modelResult.withError("0", "payJs微信扫支付查询解析请求结果失败");
			return modelResult;
		}
		WechatPayQueryResponse response = JSON.parseObject(respStr,WechatPayQueryResponse.class);
		if(response == null || response.getReturnCode().equals("0")) {
			modelResult.withError("0", "请求失败");
			return modelResult;
		}
		
//		int status = response.getStatus();
//		if(status == 0) {
//			modelResult.withError("0", "支付失败");
//			return modelResult;
//		}
		modelResult.setModel(response);
		return modelResult;
	}

}
