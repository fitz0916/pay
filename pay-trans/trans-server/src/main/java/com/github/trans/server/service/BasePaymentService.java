package com.github.trans.server.service;

import java.util.List;

import org.apache.commons.collections.CollectionUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.github.appmodel.domain.result.ModelResult;
import com.github.pattern.client.service.AgentServiceClient;
import com.github.pattern.client.service.CustomerServiceClient;
import com.github.pattern.client.service.ShopServiceClient;
import com.github.pattern.common.domain.Agent;
import com.github.pattern.common.domain.Customer;
import com.github.pattern.common.domain.Shop;
import com.github.trans.common.annotation.PayResponseCodeEnum;
import com.github.trans.common.request.PaymentRequest;
import com.github.trans.common.request.TransRequest;
import com.github.trans.common.response.PaymentResponse;
import com.github.trans.common.response.TransResponse;
import com.github.trans.common.utils.BeanValidatorUtils;
import com.github.trans.common.utils.PaySignUtil;

public abstract class BasePaymentService<Q extends TransRequest,P extends TransResponse> {

	private final static Logger LOGGER = LoggerFactory.getLogger(BasePaymentService.class);
	
	@Autowired
	private AgentServiceClient agentServiceClient;
	@Autowired
	private ShopServiceClient shopServiceClient;
	@Autowired
	private CustomerServiceClient customerServiceClient;
	
	/***
	 * 检查请求参数是否为空
	 * @param paymentRequest
	 * @return
	 */
	protected ModelResult<PaymentResponse> checkRequestParams(PaymentRequest paymentRequest){
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
		return modelResult;
	}
	
	
	protected ModelResult<Customer> checkPaymentStatus(PaymentRequest paymentRequest){
		ModelResult<Customer> modelResult = new ModelResult<Customer>();
		String customerNo = paymentRequest.getCustomerNo();
		ModelResult<Customer> customerModelResult = customerServiceClient.selectByCustomerNo(customerNo);
		if(!customerModelResult.isSuccess()) {
			String errorMsg = customerModelResult.getErrorMsg();
			LOGGER.error("商户号:customerNo = 【{}】请求错误,errorMsg = 【{}】",customerNo,errorMsg);
			modelResult.withError("0",errorMsg);
			return modelResult;
		}
		if(customerModelResult.getModel() == null) {
			LOGGER.error("商户号:customerNo = 【{}】请求商户不存在",customerNo);
			modelResult.withError("0","请求商户不存在");
			return modelResult;
		}
		Customer customer = customerModelResult.getModel();
		int customerStatus = customer.getStatus();
		if(customerStatus == 0) {
			LOGGER.error("商户号customerNo = 【{}】已停用",customerNo);
			modelResult.withError("0","请求商户已停用");
			return modelResult;
		}
		Integer shopId = customer.getShopId();
		LOGGER.info("商户号customerNo = 【[]】,门店ID为shopID = 【{}】",customerNo,shopId);
		ModelResult<Shop> shopModelResult = shopServiceClient.selectByPrimaryKey(customer.getShopId());
		if(!shopModelResult.isSuccess()) {
			String errorMsg = shopModelResult.getErrorMsg();
			LOGGER.error("商户号customerNo = 【{}】,门店ID为shopID = 【{}】请求错误,errorMsg = 【{}】",customerNo,shopId,errorMsg);
			modelResult.withError("0",errorMsg);
			return modelResult;
		}
		if(shopModelResult.getModel() == null) {
			LOGGER.error("商户号customerNo = 【{}】,门店ID为shopID = 【{}】不存在",customerNo,shopId);
			modelResult.withError("0","请求商户对应的门店不存在");
			return modelResult;
		}
		Shop shop = shopModelResult.getModel();
		int shopStatus = shop.getStatus();
		if(shopStatus == 0) {
			LOGGER.error("商户号customerNo = 【{}】,门店ID为shopID = 【{}】已停用",customerNo,shopId);
			modelResult.withError("0","请求商户对应的门店已停用");
			return modelResult;
		}
		Integer agentId = shop.getAgentId();
		ModelResult<Agent> agentModelResult = agentServiceClient.selectByPrimaryKey(agentId);
		if(!agentModelResult.isSuccess()) {
			String errorMsg = agentModelResult.getErrorMsg();
			LOGGER.error("商户号customerNo = 【{}】,门店ID为shopID = 【{}】,代理商ID为agentId = 【{}】请求错误,errorMsg = 【{}】",customerNo,shopId,agentId,errorMsg);
			modelResult.withError("0",errorMsg);
			return modelResult;
		}
		if(agentModelResult.getModel() == null) {
			LOGGER.error("商户号customerNo = 【{}】,门店ID为shopID = 【{}】,代理商ID为agentId = 【{}】不存在",customerNo,shopId,agentId);
			modelResult.withError("0","请求商户对应的代理商不存在");
			return modelResult;
		}
		Agent agent = agentModelResult.getModel();
		int agentStatus = agent.getStatus();
		if(agentStatus == 0) {
			LOGGER.error("商户号customerNo = 【{}】,门店ID为shopID = 【{}】,代理商ID为agentId = 【{}】已停用",customerNo,shopId,agentId);
			modelResult.withError("0","请求商户对应的代理商已停用");
			return modelResult;
		}
		modelResult.setModel(customer);
		return modelResult;
	}
	
	
	/***
	 * 检查请求签名
	 * @param paymentRequest
	 * @return
	 */
	protected ModelResult<PaymentResponse> checkRequestSign(PaymentRequest paymentRequest,Customer customer){
		ModelResult<PaymentResponse> modelResult = new ModelResult<PaymentResponse>();
		String customerNo = customer.getCustomerNo();
		String merKey = customer.getCipher();
		try {
			String sign  = PaySignUtil.requestMd5Sign(paymentRequest, merKey);
			String customerSign = paymentRequest.getSign();
			if(!sign.equals(customerSign)) {
				LOGGER.error("商户号customerNo = 【{}】验签失败，商户传递customerSign = 【{}】,系统验证 = 【{}】不一致",customerNo,customerSign,sign);
				String errorCode = PayResponseCodeEnum.CHECK_SIGN_FAILURE.getCode();
				String errorMsg = PayResponseCodeEnum.CHECK_SIGN_FAILURE.getMsg();
				modelResult.withError(errorCode,errorMsg);
			}
		}catch(Exception e) {
			LOGGER.error("商户号customerNo = 【{}】验签失败，失败原因 errorMsg = 【{}】",customerNo,e.getMessage());
			String errorCode = PayResponseCodeEnum.CHECK_SIGN_FAILURE.getCode();
			String errorMsg = PayResponseCodeEnum.CHECK_SIGN_FAILURE.getMsg();
			modelResult.withError(errorCode,errorMsg);
		}
		return modelResult;
	}
	
	/***
	 * 检查风控
	 * @param paymentRequest
	 * @return
	 */
	protected ModelResult<PaymentResponse> checkRisk(PaymentRequest paymentRequest){
		ModelResult<PaymentResponse> modelResult = new ModelResult<PaymentResponse>();
		return modelResult;
	}
}
