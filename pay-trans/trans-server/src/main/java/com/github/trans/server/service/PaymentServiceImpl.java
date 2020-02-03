package com.github.trans.server.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import com.github.appmodel.domain.result.ModelResult;
import com.github.pattern.common.domain.Customer;
import com.github.pattern.common.domain.CustomerPaymentChannelInfo;
import com.github.trans.common.request.PaymentRequest;
import com.github.trans.common.response.PaymentResponse;
import com.github.trans.common.service.PaymentService;
import com.github.trans.common.service.ThirdChannelService;
import com.github.trans.server.service.base.BasePaymentService;

/***
 * 支付接口 
 * Date 2020-02-25 21:35
 * @author xieyongpei
 *
 */
@Service
public class PaymentServiceImpl extends BasePaymentService<PaymentRequest,PaymentResponse> implements PaymentService{

	private final static Logger LOGGER = LoggerFactory.getLogger(PaymentServiceImpl.class);
	
	
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
		//检测订单号是否存在
		modelResult = this.checkPaymentOrder(paymentRequest);
		if(!modelResult.isSuccess()) {
			return modelResult;
		}
		
		modelResult = this.checkRisk(paymentRequest);
		//风控检测
		if(!modelResult.isSuccess()) {
			return modelResult;
		}
		String payType = paymentRequest.getPayType();
		String customerNo = paymentRequest.getCustomerNo();
		//选择渠道，这里使用策略模式，根据支付类型来选择渠道
		ModelResult<CustomerPaymentChannelInfo> channelInfoModelResult = this.selectPaymentChannel(customer,payType);
		if(!channelInfoModelResult.isSuccess()) {
			String errorCode = channelInfoModelResult.getErrorCode();
			String errorMsg = channelInfoModelResult.getErrorMsg();
			LOGGER.error("商户customerNo = 【{}】获取商户支付渠道失败,errorCode = 【{}】,errorMsg = 【{}】",customerNo,errorCode,errorMsg);
			modelResult.withError(errorCode, errorMsg);
			return modelResult;
		}
		CustomerPaymentChannelInfo customerPaymentChannelInfo = channelInfoModelResult.getModel();
		ModelResult<ThirdChannelService> thirdChannelModelResult = this.selectThirdChannel(customerPaymentChannelInfo);
		if(!thirdChannelModelResult.isSuccess()) {
			String errorCode = channelInfoModelResult.getErrorCode();
			String errorMsg = channelInfoModelResult.getErrorMsg();
			LOGGER.error("商户customerNo = 【{}】获取三方支付渠道失败,errorCode = 【{}】,errorMsg = 【{}】",customerNo,errorCode,errorMsg);
			modelResult.withError(errorCode, errorMsg);
			return modelResult;
		}
		ThirdChannelService thirdChannelService = thirdChannelModelResult.getModel();
		modelResult = thirdChannelService.process(paymentRequest, customer,customerPaymentChannelInfo);
		return modelResult;
	}

}
