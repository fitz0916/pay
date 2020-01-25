package com.github.trans.server.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.appmodel.domain.result.ModelResult;
import com.github.pattern.client.service.AgentServiceClient;
import com.github.pattern.client.service.CustomerServiceClient;
import com.github.pattern.client.service.ShopServiceClient;
import com.github.pattern.common.domain.Customer;
import com.github.trans.common.request.PaymentRequest;
import com.github.trans.common.response.PaymentResponse;
import com.github.trans.common.service.PaymentService;
import com.github.trans.common.utils.BeanValidatorUtils;

/***
 * 支付接口 
 * Date 2020-02-25 21:35
 * @author xieyongpei
 *
 */
@Service
public class PaymentServiceImpl extends BasePaymentService<PaymentRequest,PaymentResponse> implements PaymentService<PaymentRequest,PaymentResponse>{

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
		modelResult = this.checkRequestParams(paymentRequest);
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
		//选择渠道，这里使用策略模式，根据支付类型来选择渠道
		
		return modelResult;
	}

}
