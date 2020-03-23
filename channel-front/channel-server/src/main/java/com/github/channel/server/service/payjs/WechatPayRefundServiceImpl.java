package com.github.channel.server.service.payjs;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.github.appmodel.domain.result.ModelResult;
import com.github.channel.common.constants.ChannelConstants;
import com.github.channel.common.request.payjs.WechatPayQuerySignRequest;
import com.github.channel.common.request.payjs.WechatPayRefundRequest;
import com.github.channel.common.response.payjs.WechatPayRefundResponse;
import com.github.channel.common.service.payjs.WechatPayRefundService;
import com.github.channel.common.utils.BeanValidatorUtils;
import com.github.channel.common.utils.OkHttpUtil;
import com.github.channel.common.utils.PayJsSignUtils;
import com.github.channel.server.service.BaseTradeService;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class WechatPayRefundServiceImpl extends BaseTradeService<WechatPayRefundRequest, WechatPayRefundResponse> implements WechatPayRefundService<WechatPayRefundRequest, WechatPayRefundResponse> {

	private final static Logger LOGGER = LoggerFactory.getLogger(WechatPayRefundServiceImpl.class);
	
	@Override
	public ModelResult<WechatPayRefundResponse> refund(WechatPayRefundRequest request) {
		LOGGER.info("用户请求对象数据 WechatPayRequest = 【{}】",request);
		ModelResult<WechatPayRefundResponse> modelResult = this.process(request);
		return modelResult;
	}

	@Override
	protected ModelResult<String> checkParamter(WechatPayRefundRequest request) {
		ModelResult<String> modelResult = new ModelResult<String>();
		if(request == null) {
			LOGGER.error("请求对象为空！");
			modelResult.withError("0", "非法请求数据");
			return modelResult;
		}
		List<String> list = BeanValidatorUtils.validateParam(request);
		if(CollectionUtils.isNotEmpty(list)) {
			String errorMsg = list.toString();
			LOGGER.warn("退款请求参数包含以下属性数据为空,errorMsg = 【{}】",errorMsg);
			modelResult.withError("0", errorMsg);
			return modelResult;
		}
		return modelResult;
	}

	@Override
	protected ModelResult<WechatPayRefundResponse> processWithJson(WechatPayRefundRequest request) {
		ModelResult<WechatPayRefundResponse> modelResult = new ModelResult<WechatPayRefundResponse>();
		try {
			WechatPayQuerySignRequest payJsSignRequest = getSign(request);
			String sign = PayJsSignUtils.getSign(payJsSignRequest,request.getSecretKey());
			request.setSign(sign);
			String url = request.getUrl() + ChannelConstants.PAYJS_REFUND_SUFFIX;
//			String url = request.getUrl();
			JSONObject requestJSON = this.initJSONObject(request);
			String result = null;
		    result = OkHttpUtil.getInstance().postWithJson(url, requestJSON);
		LOGGER.info("******payJs退款请求结果************* result = 【{}】",result);
		modelResult = parse(request, result);
	}catch(Exception e) {
		LOGGER.error("payJS支付退款请求失败,errorMsg = 【{}】",e.getMessage());
		modelResult.withError("0", "退款请求失败");
		return modelResult;
	}
		return modelResult;
}

	private JSONObject initJSONObject(WechatPayRefundRequest request) {
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("payjs_order_id", request.getPayjsOrderId());
		jsonObject.put("sign", request.getSign());
		return jsonObject;
	}

	private WechatPayQuerySignRequest getSign(WechatPayRefundRequest request) {
		WechatPayQuerySignRequest wechatPayQuerySignRequest = new WechatPayQuerySignRequest();
		wechatPayQuerySignRequest.setPayjsOrderId(request.getPayjsOrderId());
		return wechatPayQuerySignRequest;
	}

	@Override
	protected ModelResult<WechatPayRefundResponse> parse(WechatPayRefundRequest request, String respStr) {
		ModelResult<WechatPayRefundResponse> modelResult = new ModelResult<WechatPayRefundResponse>();
		if(StringUtils.isBlank(respStr)) {
			modelResult.withError("0", "payJs微信支付退款解析请求结果失败");
			return modelResult;
		}
		WechatPayRefundResponse response = JSON.parseObject(respStr, WechatPayRefundResponse.class);
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
