package com.github.trans.server.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.github.appmodel.domain.result.ModelResult;
import com.github.trans.common.request.PaymentRequest;
import com.github.trans.common.response.PaymentResponse;
import com.github.trans.common.service.PaymentService;
import com.github.trans.common.utils.BeanValidatorUtils;

/***
 * 支付接口
 * @author xieyongpei
 *
 */
@Service
public class PaymentServiceImpl extends BasePaymentService<PaymentRequest,PaymentResponse> implements PaymentService<PaymentRequest,PaymentResponse>{


	@Override
	public ModelResult<PaymentResponse> pay(PaymentRequest paymentRequest) {
		ModelResult<PaymentResponse> modelResult = new ModelResult<PaymentResponse>();
		//参数检测
		modelResult = this.checkRequestParams(paymentRequest);
		if(!modelResult.isSuccess()) {
			return modelResult;
		}
		//签名检测
		modelResult = this.checkRequestSign(paymentRequest);
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

	public static void main(String args[]) {
		PaymentRequest request = new PaymentRequest();
		List<String> list = BeanValidatorUtils.validateParam(request);
		System.out.println(list.toString());
	}
}
