package com.github.pattern.web.controller;

import java.util.List;

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
import com.github.pattern.client.service.PaymentChannelAccountServiceClient;
import com.github.pattern.common.domain.PaymentChannelAccount;
import com.github.pattern.common.utils.ResultUtils;
import com.github.pattern.utils.LengthValidator;

import io.swagger.annotations.ApiOperation;

@Controller
@RequestMapping("/manage/paymentchannelaccount")
public class PaymentChannelAccountController {

	
	@Autowired
	private PaymentChannelAccountServiceClient paymentChannelAccountServiceClient;
	
	
	@ApiOperation("支付渠道账号首页")
    @RequiresPermissions("pattern:paymentchannelaccount:read")
    @RequestMapping(value = "/list/{paymentChannelId}",method = RequestMethod.POST)
	public @ResponseBody Object list(@PathVariable("paymentChannelId")Integer paymentChannelId) {
		ModelResult<List<PaymentChannelAccount>>  modelResult = paymentChannelAccountServiceClient.selectByPaymentChannelId(paymentChannelId);
		return ResultUtils.buildResult(modelResult);
		
	}
	
	
	@ApiOperation("添加支付渠道")
    @RequiresPermissions("pattern:paymentchannelaccount:create")
    @RequestMapping(value = "/create/{paymentChannelId}",method = RequestMethod.GET)
	public String create(@PathVariable("paymentChannelId")Integer paymentChannelId,ModelMap modelMap) {
		modelMap.put("paymentChannelId", paymentChannelId);
		return "/manage/paymentchannelaccount/create";
	}

	
	@ApiOperation("添加支付渠道")
    @RequiresPermissions("pattern:paymentchannelaccount:create")
    @RequestMapping(value = "/create",method = RequestMethod.POST)
	public @ResponseBody Object create(PaymentChannelAccount paymentChannelAccount) {
		ComplexResult result = valid(paymentChannelAccount);
		if (!result.isSuccess()) {
            return ResultUtils.buildErrorMsg(Constants.FAIL_MSG_CODE, result.getErrors());
        }
		ModelResult<Integer> modelResult = paymentChannelAccountServiceClient.insertSelective(paymentChannelAccount);
		return ResultUtils.buildResult(modelResult);
	}
	
	private ComplexResult valid(PaymentChannelAccount paymentChannelAccount) {
		ComplexResult result = FluentValidator.checkAll()
	            .on(paymentChannelAccount.getAccountName(), new LengthValidator(5, 50, "渠道账号名称"))
	            .doValidate()
	            .result(ResultCollectors.toComplex());
		return result;
	}

	@ApiOperation("编辑支付渠道账号")
    @RequiresPermissions("pattern:paymentchannelaccount:update")
    @RequestMapping(value = "/update/{paymentChannelAccountId}",method = RequestMethod.GET)
	public String update(@PathVariable("paymentChannelId") Integer paymentChannelAccountId,ModelMap modelMap) {
		ModelResult<PaymentChannelAccount> modelResult = paymentChannelAccountServiceClient.selectByPrimaryKey(paymentChannelAccountId);
		if(!modelResult.isSuccess()) {
			throw new NullPointerException("查询失败");
		}
		PaymentChannelAccount paymentChannelAccount = modelResult.getModel();
		modelMap.put("paymentChannelAccount", paymentChannelAccount);
		return "/manage/paymentchannelaccount/update";
	}
	
	@ApiOperation("编辑支付渠道")
    @RequiresPermissions("pattern:paymentchannelaccount:update")
    @RequestMapping(value = "/update",method = RequestMethod.POST)
	public @ResponseBody Object update(PaymentChannelAccount paymentChannelAccount) {
		ComplexResult result = valid(paymentChannelAccount);
		if (!result.isSuccess()) {
            return ResultUtils.buildErrorMsg(Constants.FAIL_MSG_CODE, result.getErrors());
        }
		ModelResult<Integer> modelResult = paymentChannelAccountServiceClient.updateByPrimaryKeySelective(paymentChannelAccount);
		return ResultUtils.buildResult(modelResult);
	}
	
	
}
