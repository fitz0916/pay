package com.github.pattern.web.controller;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.baidu.unbiz.fluentvalidator.ComplexResult;
import com.baidu.unbiz.fluentvalidator.FluentValidator;
import com.baidu.unbiz.fluentvalidator.ResultCollectors;
import com.github.admin.common.constants.Constants;
import com.github.appmodel.domain.result.ModelResult;
import com.github.pattern.client.service.CustomerPaymentChannelFeeServiceClient;
import com.github.pattern.client.service.CustomerServiceClient;
import com.github.pattern.client.service.PaymentChannelServiceClient;
import com.github.pattern.common.domain.Customer;
import com.github.pattern.common.domain.CustomerPaymentChannelFee;
import com.github.pattern.common.domain.PaymentChannel;
import com.github.pattern.common.utils.ResultUtils;
import com.github.pattern.utils.DecimalPointValidator;
import com.github.pattern.utils.NotNullValidator;

import io.swagger.annotations.ApiOperation;

@Controller
@RequestMapping("/manage/customerpaymentchannelfee")
public class CustomerPaymentChannelFeeController {
	
	@Autowired
	private CustomerServiceClient customerServiceClient;
	
	
	@Autowired
	private PaymentChannelServiceClient paymentChannelServiceClient;
	
	@Autowired
	private CustomerPaymentChannelFeeServiceClient customerChannelFeeServiceClient;
	
	
	public String index() {
		return "/manager/customerpaymentchannelfee/index";
	}
	
	
	
	@ApiOperation("添加商户费率")
    @RequiresPermissions("pattern:customerpaymentchannelfee:create")
    @RequestMapping(value = "/create/{customerId}/{paymentChannelId}",method = RequestMethod.GET)
	public String create(@PathVariable("customerId")Integer customerId,@PathVariable("paymentChannelId")Integer paymentChannelId,ModelMap modelMap) {
		ModelResult<Customer> customerModelResult = customerServiceClient.selectByPrimaryKey(customerId);
		ModelResult<PaymentChannel> paymentChannelModelResult = paymentChannelServiceClient.selectByPrimaryKey(paymentChannelId);
		if(!customerModelResult.isSuccess() || !paymentChannelModelResult.isSuccess()) {
			throw new NullPointerException("查询异常");
		}
		modelMap.put("customer", customerModelResult.getModel());
		modelMap.put("paymentChannel", paymentChannelModelResult.getModel());
		return "/manager/customerpaymentchannelfee/create";
	}
	

	@ApiOperation("添加商户费率")
    @RequiresPermissions("pattern:customerpaymentchannelfee:create")
    @RequestMapping(value = "/create",method = RequestMethod.POST)
	public @ResponseBody Object create(CustomerPaymentChannelFee customerPaymentChannelFee) {
		ComplexResult result = valid(customerPaymentChannelFee);
		if (!result.isSuccess()) {
            return ResultUtils.buildErrorMsg(Constants.FAIL_MSG_CODE, result.getErrors());
        }
		ModelResult<Integer> modelResult = customerChannelFeeServiceClient.insertSelective(customerPaymentChannelFee);
		return ResultUtils.buildResult(modelResult);
	}



	private ComplexResult valid(CustomerPaymentChannelFee customerPaymentChannelFee) {
		ComplexResult result = FluentValidator.checkAll()
	            .on(customerPaymentChannelFee.getThirdRate() != null ? customerPaymentChannelFee.getThirdRate().toString() : "",new DecimalPointValidator("接入费率"))
	            .on(customerPaymentChannelFee.getCustomerRate() != null ? customerPaymentChannelFee.getCustomerRate().toString() : "",new DecimalPointValidator("销售费率"))
	            .on(customerPaymentChannelFee.getCustomerId() != null ? customerPaymentChannelFee.getCustomerId().toString() : "",new NotNullValidator("商户ID"))
	            .on(customerPaymentChannelFee.getPaymentChannelId() != null ? customerPaymentChannelFee.getPaymentChannelId().toString() : "",new NotNullValidator("渠道ID"))
	            .doValidate()
	            .result(ResultCollectors.toComplex());
		return result;
	}
}
