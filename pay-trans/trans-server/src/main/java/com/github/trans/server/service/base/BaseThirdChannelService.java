package com.github.trans.server.service.base;

import java.math.BigDecimal;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import org.apache.commons.collections.CollectionUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.alibaba.fastjson.JSON;
import com.github.appmodel.domain.result.ModelResult;
import com.github.pattern.client.service.CustomerPaymentChannelFeeServiceClient;
import com.github.pattern.client.service.PaymentChannelAccountParaServiceClient;
import com.github.pattern.client.service.PaymentChannelAccountServiceClient;
import com.github.pattern.common.domain.Customer;
import com.github.pattern.common.domain.CustomerPaymentChannelFee;
import com.github.pattern.common.domain.CustomerPaymentChannelInfo;
import com.github.pattern.common.domain.PaymentChannelAccount;
import com.github.pattern.common.domain.PaymentChannelAccountPara;
import com.github.pattern.common.utils.AmountUtil;
import com.github.trans.common.domain.PaymentOrder;
import com.github.trans.common.request.PaymentRequest;
import com.github.trans.common.utils.DateUtil;

public abstract class BaseThirdChannelService {

	private final static Logger LOGGER = LoggerFactory.getLogger(BaseThirdChannelService.class);
	
	@Autowired
	private CustomerPaymentChannelFeeServiceClient customerPaymentChannelFeeServiceClient;
	@Autowired
	private PaymentChannelAccountServiceClient paymentChannelAccountServiceClient;
	@Autowired
	private PaymentChannelAccountParaServiceClient paymentChannelAccountParaServiceClient;
	
	
	protected ModelResult<CustomerPaymentChannelFee> initFee(Integer customerId,Integer paymentChannelId){
		ModelResult<CustomerPaymentChannelFee>  modelResult = customerPaymentChannelFeeServiceClient.selectByCustomerIdAndPaymentChannelId(customerId, paymentChannelId);
		if(!modelResult.isSuccess() || modelResult.getModel() == null || modelResult.getModel().getStatus() == 0) {
			String errorCode = modelResult.getErrorCode() == null ? "0" : modelResult.getErrorCode();
			String errorMsg = modelResult.getErrorMsg() == null ? "商户费率未设置" : modelResult.getErrorMsg();
			LOGGER.warn("customerId = 【{}】,paymentChannelId = 【{}】商户费率没有设置",customerId,paymentChannelId);
			modelResult.withError(errorCode, errorMsg);
			return modelResult;
		}
		return modelResult;
	}

	protected PaymentOrder initPaymentOrder(PaymentRequest paymentRequest,Customer customer,CustomerPaymentChannelInfo customerPaymentChannelInfo,PaymentChannelAccount paymentChannelAccount,CustomerPaymentChannelFee customerPaymentChannelFee) {
		PaymentOrder paymentOrder = new PaymentOrder();
		Date date = new Date();
		String orderNo = generateOrderNo(date);
		String customerNo = customer.getCustomerNo();
		String customerName = customer.getCustomerName();
		String thirdCustomerNo = paymentChannelAccount.getAccountName();
		Integer shopId = customer.getAgentId();
		Integer agentId = customer.getShopId();
		String notifyUrl = paymentRequest.getNotifyUrl();
		String returnUrl = paymentRequest.getReturnUrl();
		String clinetIP = paymentRequest.getClientIp();
		String currency = paymentRequest.getCurrency();
		String payType = paymentRequest.getPayType();
		String payOrderNo = paymentRequest.getPayOrderNo();
		String subject = paymentRequest.getSubject();
		String desc = paymentRequest.getDesc();
		Date transTime = DateUtil.str2Date("yyyy-MM-dd HH:mm:ss",paymentRequest.getPayTime());
		int payStatus = 0;
		BigDecimal amountBigDecimal = new BigDecimal(paymentRequest.getPayAmount()); // 支付金额
		//商户支付金额
		String payAmount = String.valueOf(AmountUtil.changeY2FLong(paymentRequest.getPayAmount()));
		//商户费率
		BigDecimal customerFee = customerPaymentChannelFee.getCustomerRate();
		//收取商户手续费(支付金额*销售商户费率)
		String customerProundage = String.valueOf(AmountUtil.feeRoundingF(amountBigDecimal, customerFee));
		
		BigDecimal thirdChannelFee = customerPaymentChannelFee.getThirdRate();
		//支付给三方渠道费率
		String thirdChannelProundage = String.valueOf(AmountUtil.feeRoundingF(amountBigDecimal, thirdChannelFee));
		//商户实际到账
		String customerAmount = String.valueOf(amountBigDecimal.subtract(new BigDecimal(customerProundage)).longValue()); 
		//***************
		Integer paymentChannelId = customerPaymentChannelInfo.getPaymentChannelId();
		Integer customerPaymentChannelInfoId = customerPaymentChannelInfo.getCustomerPaymentChannelInfoId();
		Integer paymentChannelAccountId = paymentChannelAccount.getPaymentChannelAccountId();
		
		
		//代理商费率暂时不没有设计，more为0
		BigDecimal agentFee = customerPaymentChannelFee.getAgentRate();
		String agentProundage = String.valueOf(AmountUtil.feeRoundingF(amountBigDecimal, agentFee));
		BigDecimal shopFee = customerPaymentChannelFee.getShopRate();
		String shopProundage = String.valueOf(AmountUtil.feeRoundingF(amountBigDecimal, shopFee));
		//商户实际到账金额(交易金额-交易金额*接入费率)
		int settlementType = customerPaymentChannelInfo.getSettlementType();
		int settlementStatus = 0;
		paymentOrder.setOrderNo(orderNo);
		paymentOrder.setCustomerNo(customerNo);
		paymentOrder.setAgentId(agentId);
		paymentOrder.setCustomerName(customerName);
		//三方渠道订单号，有些没有返回，设置默认值
		paymentOrder.setThirdCustomerNo(thirdCustomerNo);
		paymentOrder.setThirdChannelOrderNo("");
		paymentOrder.setPayType(payType);
		paymentOrder.setPayStatus(payStatus);
		paymentOrder.setTransTime(transTime);
		paymentOrder.setTransFinishTime(transTime);
		paymentOrder.setTopic(subject);
		paymentOrder.setDesciption(desc);
		paymentOrder.setCustomerPaymentChannelInfoId(customerPaymentChannelInfoId);
		paymentOrder.setPaymentChannelId(paymentChannelId);
		paymentOrder.setPaymentChannelAccountId(paymentChannelAccountId);
		paymentOrder.setNotifyUrl(notifyUrl);
		paymentOrder.setReturnUrl(returnUrl);
		paymentOrder.setPayAmount(payAmount);
		paymentOrder.setThirdChannelFee(thirdChannelFee);
		paymentOrder.setThirdChannelProundage(thirdChannelProundage);
		paymentOrder.setCustomerFee(customerFee);
		paymentOrder.setCustomerProundage(customerProundage);
		paymentOrder.setAgentFee(agentFee);
		paymentOrder.setAgentProundage(agentProundage);
		paymentOrder.setShopFee(shopFee);
		paymentOrder.setShopProundage(shopProundage);
		
		paymentOrder.setCustomerAmount(customerAmount);
		paymentOrder.setSettlementType(settlementType);
		paymentOrder.setSettlementStatus(settlementStatus);
		paymentOrder.setCurrency(currency);
		paymentOrder.setShopId(shopId);
		paymentOrder.setAgentId(agentId);
		paymentOrder.setClientIp(clinetIP);
		paymentOrder.setCustomerOrderNo(payOrderNo);
		
		
		return paymentOrder;
		
	}
	
	public synchronized static String generateOrderNo(Date date) {
		String orderId = DateUtil.date2Str("yyyyMMddHHmmssSSS", date);
		String randomNum = new Random().nextInt(100000) + "";
		if (randomNum.length() < 6) {
			for (int x = 0; x <= 6 - randomNum.length(); x++) {
				randomNum += "0";
			}
		}
		return orderId + randomNum;
	}
	
	protected ModelResult<PaymentChannelAccount> selectChannelAccount(CustomerPaymentChannelInfo customerPaymentChannelInfo){
		ModelResult<PaymentChannelAccount> modelResult = new ModelResult<PaymentChannelAccount>();
		Integer paymentChannelId = customerPaymentChannelInfo.getPaymentChannelId();
		String customerNo = customerPaymentChannelInfo.getCustomerNo();
		ModelResult<List<PaymentChannelAccount>> accountModelResult = paymentChannelAccountServiceClient.selectByPaymentChannelId(paymentChannelId);
		if(!accountModelResult.isSuccess()) {
			modelResult.withError("0", "获取渠道账号失败获取没有配置");
			LOGGER.error("商户号customerNo = 【{}】获取账号渠道失败",customerNo);
			return modelResult;
		}
		if(CollectionUtils.isEmpty(accountModelResult.getModel())){
			LOGGER.error("商户号customerNo = 【{}】没有配置渠道账号参数",customerNo);
			modelResult.withError("0", "商户没有设置账号渠道参数");
			return modelResult;
		}
		List<PaymentChannelAccount> list = accountModelResult.getModel();
		int listSize = list.size();
		int index = 0;
		if(listSize > 1) {
			 index = new Random().nextInt(listSize - 1);
		}
		PaymentChannelAccount paymentChannelAccount = list.get(index);
		if(paymentChannelAccount == null) {
			modelResult.withError("0", "获取渠道账号失败获");
			return modelResult;
		}
		modelResult.setModel(paymentChannelAccount);
		return modelResult;
	}
	
	
	protected ModelResult<String> initAccountChannelParams(PaymentChannelAccount paymentChannelAccount){
		ModelResult<String> modelResult = new ModelResult<String>();
		Integer paymentChannelAccountId = paymentChannelAccount.getPaymentChannelAccountId();
		ModelResult<List<PaymentChannelAccountPara>> paramModelResult = paymentChannelAccountParaServiceClient.selectByPaymentChannelAccountId(paymentChannelAccountId);
		if(!paramModelResult.isSuccess() || CollectionUtils.isEmpty(paramModelResult.getModel())) {
			modelResult.withError("0", "渠道账号参数未设置");
			return modelResult;
		}
		String getAccountParamJson = getAccountParamJson(paramModelResult.getModel());
		modelResult.setModel(getAccountParamJson);
		return modelResult;
		
	}
	
	private String getAccountParamJson(List<PaymentChannelAccountPara> list) {
		Map<String,String> map = new HashMap<String,String>();
		for(PaymentChannelAccountPara para:list) {
			if(para.getStatus() == 1) {
				map.put(para.getName(), para.getValue());
			}
		}
		String accountJson = JSON.toJSONString(map);
		return accountJson;
	}
}

