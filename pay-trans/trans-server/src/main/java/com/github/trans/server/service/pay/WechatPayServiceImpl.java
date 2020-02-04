package com.github.trans.server.service.pay;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSON;
import com.github.appmodel.domain.result.ModelResult;
import com.github.channel.client.service.payjs.WechatPayQueryServiceClient;
import com.github.channel.client.service.payjs.WechatPayServiceClient;
import com.github.channel.common.request.payjs.WechatPayQueryRequest;
import com.github.channel.common.request.payjs.WechatPayRequest;
import com.github.channel.common.response.payjs.WechatPayQueryResponse;
import com.github.channel.common.response.payjs.WechatPayResponse;
import com.github.pattern.common.domain.Customer;
import com.github.pattern.common.domain.CustomerPaymentChannelFee;
import com.github.pattern.common.domain.CustomerPaymentChannelInfo;
import com.github.pattern.common.domain.PaymentChannelAccount;
import com.github.pattern.common.utils.AmountUtil;
import com.github.trans.common.domain.PaymentOrder;
import com.github.trans.common.request.PaymentRequest;
import com.github.trans.common.response.PaymentQueryResponse;
import com.github.trans.common.response.PaymentResponse;
import com.github.trans.common.service.PaymentOrderService;
import com.github.trans.common.service.ThirdChannelService;
import com.github.trans.common.utils.PaySignUtil;
import com.github.trans.server.service.base.BaseThirdChannelService;

@Service
public class WechatPayServiceImpl extends BaseThirdChannelService implements ThirdChannelService{
	
	private final static Logger LOGGER = LoggerFactory.getLogger(WechatPayServiceImpl.class);
	
	@Autowired
	private WechatPayServiceClient wechatPayServiceClient;
	
	@Autowired
	private WechatPayQueryServiceClient wechatPayQueryServiceClient;
	
	@Autowired
	private PaymentOrderService paymentOrderServiceImpl;
	
	@Override
	public ModelResult<PaymentResponse> pay(PaymentRequest request, Customer customer,CustomerPaymentChannelInfo customerPaymentChannelInfo) {
		LOGGER.info("微信扫码支付.............");
		ModelResult<PaymentResponse> modelResult = new ModelResult<PaymentResponse>();
		ModelResult<PaymentChannelAccount> accountModelResult = this.selectChannelAccount(customerPaymentChannelInfo);
		if(!accountModelResult.isSuccess()) {
			String errorCode = accountModelResult.getErrorCode();
			String errorMsg = accountModelResult.getErrorMsg();
			LOGGER.error("获取渠道账号失败 errorCode = 【{}】,errorMsg = 【{}】",errorCode,errorMsg);
			modelResult.withError(errorCode, errorMsg);
			return modelResult;
		}
		PaymentChannelAccount paymentChannelAccount = accountModelResult.getModel();
		ModelResult<String> paramsModelResult = initAccountChannelParams(paymentChannelAccount);
		if(!paramsModelResult.isSuccess()) {
			String errorCode = accountModelResult.getErrorCode();
			String errorMsg = accountModelResult.getErrorMsg();
			LOGGER.error("获取渠道账号参数失败 errorCode = 【{}】,errorMsg = 【{}】",errorCode,errorMsg);
			modelResult.withError(errorCode, errorMsg);
			return modelResult;
		}
		String paramsJson = paramsModelResult.getModel();
		ModelResult<WechatPayRequest> wechatResultModelResult = initWechatPayRequest(request, paramsJson);
		if(!wechatResultModelResult.isSuccess()) {
			String errorCode = accountModelResult.getErrorCode();
			String errorMsg = accountModelResult.getErrorMsg();
			modelResult.withError(errorCode, errorMsg);
			return modelResult;
		}
		WechatPayRequest wechatPayRequest = wechatResultModelResult.getModel();
		ModelResult<WechatPayResponse> wechatModelResult = wechatPayServiceClient.pay(wechatPayRequest);
		if(!wechatModelResult.isSuccess() || wechatModelResult.getModel() == null) {
			String errorMsg = wechatModelResult.getErrorMsg();
			String errorCode = wechatModelResult.getErrorCode();
			LOGGER.error("payJs微信扫码支付请求失败,errorCode = 【{}】,errorMsg = 【{}】",errorCode,errorMsg);
			modelResult.withError(errorCode, errorMsg);
			return modelResult;
		}
		Integer customerId = customer.getCustomerId();
		Integer paymentChannelId = customerPaymentChannelInfo.getPaymentChannelId();
		ModelResult<CustomerPaymentChannelFee> feeModelResult = initFee(customerId, paymentChannelId);
		if(!feeModelResult.isSuccess()) {
			String errorCode = accountModelResult.getErrorCode();
			String errorMsg = accountModelResult.getErrorMsg();
			LOGGER.error("获取渠道费率失败 errorCode = 【{}】,errorMsg = 【{}】",errorCode,errorMsg);
			modelResult.withError(errorCode, errorMsg);
			return modelResult;
		}
		CustomerPaymentChannelFee customerPaymentChannelFee = feeModelResult.getModel();
		WechatPayResponse wechatPayResponse = wechatModelResult.getModel();
		String customerNo = request.getCustomerNo();
		PaymentOrder paymentOrder = initPaymentOrder(request,customer,customerPaymentChannelInfo,paymentChannelAccount,customerPaymentChannelFee);
		String qrCode = wechatPayResponse.getQrcode();
		String payjsOrderId = wechatPayResponse.getPayjsOrderId();
		paymentOrder.setQrCode(qrCode);
		paymentOrder.setThirdChannelOrderNo(payjsOrderId);
		ModelResult<Integer> orderModelResult = paymentOrderServiceImpl.insertSelective(paymentOrder);
		if(!orderModelResult.isSuccess()) {
			String errorCode = "0";
			String errorMsg = "订单保存失败";
			LOGGER.error("商户号customerNo = 【{}】支付订单保存失败",customerNo);
			modelResult.withError(errorCode, errorMsg);
			return modelResult;
		}
		PaymentResponse response = initResponse(request,customer,wechatPayResponse,paymentOrder);
		LOGGER.info("pasyJs渠道请求响应结果:payJsResponse = 【{}】",response);
		modelResult.setModel(response);
		return modelResult;
	}

	
	private PaymentResponse initResponse(PaymentRequest request,Customer customer,WechatPayResponse wechatPayResponse,PaymentOrder paymentOrder){
		PaymentResponse response = new PaymentResponse();
		String customerNo = customer.getCustomerNo();
		String orderNo = paymentOrder.getOrderNo();
		String cipher = customer.getCipher();
		response.setQrCode(wechatPayResponse.getQrcode());
		response.setCustomerNo(customerNo);
		response.setPayType(request.getPayType());
		response.setPayAmount(request.getPayAmount());
		response.setPayOrderNo(request.getPayOrderNo());
		response.setOrderNo(orderNo);
		String sign  = PaySignUtil.requestMd5Sign(response, cipher);
		response.setSign(sign);
		return response;
	}
	
	private ModelResult<WechatPayRequest> initWechatPayRequest(PaymentRequest request,String json){
		ModelResult<WechatPayRequest> modelResult = new ModelResult<WechatPayRequest>();
		WechatPayRequest wechatPayRequest = null;
		try {
			wechatPayRequest = JSON.parseObject(json,WechatPayRequest.class);
			if(wechatPayRequest == null) {
				modelResult.withError("0", "渠道账号参数解析错误");
				return modelResult;
			}
			wechatPayRequest.setAttach(request.getFeature());
			wechatPayRequest.setBody(request.getSubject());
			wechatPayRequest.setNotifyUrl(request.getNotifyUrl());
			wechatPayRequest.setOutTradeNo(request.getPayOrderNo());
			String amount = AmountUtil.changeY2FLong(request.getPayAmount()).toString();
			LOGGER.info("交易金额为amount = 【{}】",amount);
			wechatPayRequest.setTotalFee(amount);
			modelResult.setModel(wechatPayRequest);
		}catch(Exception e) {
			modelResult.withError("0", "渠道账号参数配置错误");
			LOGGER.error("渠道账号参数配置错误 exceptionMsg = 【{}】",e.getMessage());
			return modelResult;
		}
		return modelResult;
	}


	@Override
	public ModelResult<PaymentQueryResponse> query(PaymentOrder paymentOrder,Customer customer,CustomerPaymentChannelInfo customerPaymentChannelInfo) {
		ModelResult<PaymentQueryResponse> modelResult = new ModelResult<PaymentQueryResponse>();
		ModelResult<PaymentChannelAccount> accountModelResult = this.selectChannelAccount(customerPaymentChannelInfo);
		if(!accountModelResult.isSuccess()) {
			String errorCode = accountModelResult.getErrorCode();
			String errorMsg = accountModelResult.getErrorMsg();
			LOGGER.error("获取渠道账号失败 errorCode = 【{}】,errorMsg = 【{}】",errorCode,errorMsg);
			modelResult.withError(errorCode, errorMsg);
			return modelResult;
		}
		PaymentChannelAccount paymentChannelAccount = accountModelResult.getModel();
		ModelResult<String> paramsModelResult = initAccountChannelParams(paymentChannelAccount);
		if(!paramsModelResult.isSuccess()) {
			String errorCode = accountModelResult.getErrorCode();
			String errorMsg = accountModelResult.getErrorMsg();
			LOGGER.error("获取渠道账号参数失败 errorCode = 【{}】,errorMsg = 【{}】",errorCode,errorMsg);
			modelResult.withError(errorCode, errorMsg);
			return modelResult;
		}
		String paramsJson = paramsModelResult.getModel();
		String customerNo = paymentOrder.getCustomerNo();
		String customerOrderNo = paymentOrder.getCustomerOrderNo();
		String thirdChannelOrderNo = paymentOrder.getThirdChannelOrderNo();
		ModelResult<WechatPayQueryRequest> wechatResultModelResult = initWechatPayQueryRequest(thirdChannelOrderNo,paramsJson);
		if(!wechatResultModelResult.isSuccess()) {
			String errorCode = accountModelResult.getErrorCode();
			String errorMsg = accountModelResult.getErrorMsg();
			modelResult.withError(errorCode, errorMsg);
			return modelResult;
		}
		WechatPayQueryRequest request = wechatResultModelResult.getModel();
		ModelResult<WechatPayQueryResponse> queryModelResult = wechatPayQueryServiceClient.query(request);
		if(!queryModelResult.isSuccess()) {
			String errorCode = accountModelResult.getErrorCode();
			String errorMsg = accountModelResult.getErrorMsg();
			LOGGER.error("payJs查询订单支付失败 errorCode = 【{}】,errorMsg = 【{}】",errorCode,errorMsg);
			modelResult.withError(errorCode, errorMsg);
			return modelResult;
		}
		WechatPayQueryResponse wechatPayQueryResponse = queryModelResult.getModel();
		PaymentOrder record = new PaymentOrder();
		record.setOrderNo(paymentOrder.getOrderNo());
		int status = wechatPayQueryResponse.getStatus();
		if(status == 1) {
			record.setPayStatus(1);
		}else {
			record.setPayStatus(2);
		}
		paymentOrderServiceImpl.updateByPrimaryKeySelective(record);
		PaymentQueryResponse paymentQueryResponse = new PaymentQueryResponse();
		paymentQueryResponse.setCustomerNo(customerNo);
		paymentQueryResponse.setPayOrderNo(customerOrderNo);
		paymentQueryResponse.setPayStatus(String.valueOf(record.getPayStatus()));
		String cipher = customer.getCipher();
		String sign  = PaySignUtil.requestMd5Sign(paymentQueryResponse, cipher);
		paymentQueryResponse.setSign(sign);
		modelResult.setModel(paymentQueryResponse);
		return modelResult;
	}


	private ModelResult<WechatPayQueryRequest> initWechatPayQueryRequest(String thirdChannelOrderNo,String paramsJson) {
		ModelResult<WechatPayQueryRequest> modelResult = new ModelResult<WechatPayQueryRequest>();
		WechatPayQueryRequest wechatPayRequest = null;
		try {
			wechatPayRequest = JSON.parseObject(paramsJson,WechatPayQueryRequest.class);
			if(wechatPayRequest == null) {
				modelResult.withError("0", "渠道账号参数解析错误");
				return modelResult;
			}
			wechatPayRequest.setPayjsOrderId(thirdChannelOrderNo);
			modelResult.setModel(wechatPayRequest);
		}catch(Exception e) {
			modelResult.withError("0", "渠道账号参数配置错误");
			LOGGER.error("渠道账号参数配置错误 exceptionMsg = 【{}】",e.getMessage());
			return modelResult;
		}
		return modelResult;
	}
	

}
