package com.github.trans.server.service;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.appmodel.domain.result.ModelResult;
import com.github.pattern.client.service.AgentServiceClient;
import com.github.pattern.client.service.CustomerServiceClient;
import com.github.pattern.client.service.ShopServiceClient;
import com.github.pattern.common.domain.Customer;
import com.github.trans.common.request.PaymentRequest;
import com.github.trans.common.request.TransRequest;
import com.github.trans.common.response.PaymentResponse;
import com.github.trans.common.response.TransResponse;
import com.github.trans.common.service.PaymentService;
import com.github.trans.common.service.ThirdChannelService;
import com.github.trans.context.ThirdChannelContext;

/***
 * 支付接口 
 * Date 2020-02-25 21:35
 * @author xieyongpei
 *
 */
@Service
public class PaymentServiceImpl extends BasePaymentService implements PaymentService{

	private final static Logger LOGGER = LoggerFactory.getLogger(PaymentServiceImpl.class);
	
	@Autowired
	private AgentServiceClient agentServiceClient;
	@Autowired
	private ShopServiceClient shopServiceClient;
	@Autowired
	private CustomerServiceClient customerServiceClient;
	
	
	@Override
	public ModelResult<PaymentResponse> pay(PaymentRequest paymentRequest) {
		ModelResult<PaymentResponse> modelResult = new ModelResult<PaymentResponse>();
		//参数检测
		modelResult = this.checkRequestParamter(paymentRequest);
		if(!modelResult.isSuccess()) {
			return modelResult;
		}
		ModelResult<Customer> customerModelResult = this.checkPaymentStatus(paymentRequest);
		if(!customerModelResult.isSuccess()) {
			String errorCode = customerModelResult.getErrorCode();
			String errorMsg = customerModelResult.getErrorMsg();
			modelResult.withError(errorCode, errorMsg);
			return modelResult;
		}
		Customer customer = customerModelResult.getModel();
		//签名检测
		modelResult = this.checkRequestSign(paymentRequest,customer);
		if(!modelResult.isSuccess()) {
			return modelResult;
		}
		modelResult = this.checkRisk(paymentRequest);
		//风控检测
		if(!modelResult.isSuccess()) {
			return modelResult;
		}
		String payType = paymentRequest.getPayType();
		String templateName = "";
		//选择渠道，这里使用策略模式，根据支付类型来选择渠道
		ModelResult<ThirdChannelService> thirdModelResult = this.selectPaymentChannel(customer,payType);
		if(!thirdModelResult.isSuccess()) {
			String errorCode = thirdModelResult.getErrorCode();
			String errorMsg = thirdModelResult.getErrorMsg();
			LOGGER.error("获取支付渠道失败,errorCode = 【{}】,errorMsg = 【{}】",errorCode,errorMsg);
			modelResult.withError(errorCode, errorMsg);
			return modelResult;
		}
		ThirdChannelService thirdChannelService = thirdModelResult.getModel();
		modelResult = thirdChannelService.process(paymentRequest, customer);
		return modelResult;
	}

}
