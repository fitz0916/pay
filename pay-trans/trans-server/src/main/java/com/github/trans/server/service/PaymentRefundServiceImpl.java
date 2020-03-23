package com.github.trans.server.service;

import com.github.appmodel.domain.result.ModelResult;
import com.github.pattern.common.domain.Customer;
import com.github.pattern.common.domain.CustomerPaymentChannelInfo;
import com.github.trans.common.domain.PaymentOrder;
import com.github.trans.common.request.PaymentQueryRequest;
import com.github.trans.common.response.PaymentQueryResponse;
import com.github.trans.common.service.PaymentQueryService;
import com.github.trans.common.service.ThirdChannelService;
import com.github.trans.server.service.base.BasePaymentService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

@Service
public class PaymentRefundServiceImpl extends BasePaymentService<PaymentQueryRequest, PaymentQueryResponse> implements PaymentQueryService {

	private final static Logger LOGGER = LoggerFactory.getLogger(PaymentRefundServiceImpl.class);
	
	@Override
	public ModelResult<PaymentQueryResponse> query(PaymentQueryRequest request) {
		 ModelResult<PaymentQueryResponse> modelResult = new ModelResult<PaymentQueryResponse>();
	 		//参数检测
			modelResult = this.checkRequestParamter(request);
			if(!modelResult.isSuccess()) {
				return modelResult;
			}
			ModelResult<Customer> customerModelResult = this.checkPaymentStatus(request);
			if(!customerModelResult.isSuccess()) {
				String errorCode = customerModelResult.getErrorCode();
				String errorMsg = customerModelResult.getErrorMsg();
				modelResult.withError(errorCode, errorMsg);
				return modelResult;
			}
			Customer customer = customerModelResult.getModel();
			//签名检测
			modelResult = this.checkRequestSign(request,customer);
			if(!modelResult.isSuccess()) {
				return modelResult;
			}
			ModelResult<PaymentOrder> orderModelResult = this.checkQueryOrder(request);
			if(!orderModelResult.isSuccess()) {
				String errorCode = orderModelResult.getErrorCode();
				String errorMsg = orderModelResult.getErrorMsg();
				modelResult.withError(errorCode, errorMsg);
				return modelResult;
			}
			modelResult = this.checkRisk(request);
			//风控检测
			if(!modelResult.isSuccess()) {
				return modelResult;
			}
			PaymentOrder paymentOrder = orderModelResult.getModel();
			String payType = paymentOrder.getPayType();
			String customerNo = request.getCustomerNo();
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
			modelResult = thirdChannelService.query(paymentOrder,customer,customerPaymentChannelInfo);
			
		return modelResult;
	}

}
