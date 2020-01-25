package com.github.trans.server.service;

import java.util.List;

import org.apache.commons.collections.CollectionUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.github.appmodel.domain.result.ModelResult;
import com.github.trans.common.request.PaymentRequest;
import com.github.trans.common.request.TransRequest;
import com.github.trans.common.response.PaymentResponse;
import com.github.trans.common.response.TransResponse;
import com.github.trans.common.utils.BeanValidatorUtils;

public abstract class BasePaymentService<Q extends TransRequest,P extends TransResponse> {

	private final static Logger LOGGER = LoggerFactory.getLogger(BasePaymentService.class);
	
	/***
	 * 检查请求参数是否为空
	 * @param paymentRequest
	 * @return
	 */
	public ModelResult<PaymentResponse> checkRequestParams(PaymentRequest paymentRequest){
		ModelResult<PaymentResponse> modelResult = new ModelResult<PaymentResponse>();
		if(paymentRequest == null) {
			LOGGER.error("用户请求对象为空！");
			modelResult.withError("0", "非法请求数据");
			return modelResult;
		}
		LOGGER.info("商户请求参数编码对象数据:paymentRequest = 【{}】",paymentRequest);
		paymentRequest.base64Decoder();
		LOGGER.info("商户请求参数解码对象数据:paymentRequest = 【{}】",paymentRequest);
		List<String> list = BeanValidatorUtils.validateParam(paymentRequest);
		if(CollectionUtils.isNotEmpty(list)) {
			String errorMsg = list.toString();
			LOGGER.warn("支付请求参数包含以下属性数据为空,errorMsg = 【{}】",errorMsg);
			modelResult.withError("0", errorMsg);
			return modelResult;
		}
		String clientIP = paymentRequest.getClientIp();
		if(!BeanValidatorUtils.checkIP(clientIP)) {
			LOGGER.warn("商户请求IP非法,clientIP = 【{}】",clientIP);
			modelResult.withError("0", "请求IP地址格式错误");
		}
		return modelResult;
	}
	
	/***
	 * 检查请求签名
	 * @param paymentRequest
	 * @return
	 */
	public ModelResult<PaymentResponse> checkRequestSign(PaymentRequest paymentRequest){
		ModelResult<PaymentResponse> modelResult = new ModelResult<PaymentResponse>();
		return modelResult;
	}
	
	/***
	 * 检查风控
	 * @param paymentRequest
	 * @return
	 */
	public ModelResult<PaymentResponse> checkRisk(PaymentRequest paymentRequest){
		ModelResult<PaymentResponse> modelResult = new ModelResult<PaymentResponse>();
		return modelResult;
	}
}
