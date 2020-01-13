package com.github.pattern.web.controller;

import java.util.List;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.baidu.unbiz.fluentvalidator.ComplexResult;
import com.baidu.unbiz.fluentvalidator.FluentValidator;
import com.baidu.unbiz.fluentvalidator.ResultCollectors;
import com.github.admin.common.constants.Constants;
import com.github.appmodel.domain.result.ModelResult;
import com.github.pattern.client.service.PaymentChannelAccountParaServiceClient;
import com.github.pattern.common.domain.PaymentChannelAccountPara;
import com.github.pattern.common.utils.ResultUtils;
import com.github.pattern.utils.NotBlankValidator;

import io.swagger.annotations.ApiOperation;

@Controller
@RequestMapping("/manage/paymentchannelaccountpara")
public class PaymentChannelAccountParaController {
	
	
	@Autowired
	private PaymentChannelAccountParaServiceClient paymentChannelAccountParaServiceClinet;
	
	
	
	@ApiOperation("支付渠道账号首页")
    @RequiresPermissions("pattern:paymentchannelaccountpara:read")
    @RequestMapping(value = "/list",method = RequestMethod.GET)
	public @ResponseBody Object list(@RequestParam("paymentChannelAccountId")Integer paymentChannelAccountId) {
		ModelResult<List<PaymentChannelAccountPara>>  modelResult = paymentChannelAccountParaServiceClinet.selectByPaymentChannelAccountId(paymentChannelAccountId);
		return ResultUtils.buildResult(modelResult);
		
	}
	
	@ApiOperation("添加支付渠道")
    @RequiresPermissions("pattern:paymentchannelaccountpara:create")
    @RequestMapping(value = "/create/{paymentChannelAccountId}",method = RequestMethod.GET)
	public String create(@PathVariable("paymentChannelAccountId")Integer paymentChannelAccountId,ModelMap modelMap) {
		modelMap.put("paymentChannelAccountId", paymentChannelAccountId);
		return "/manager/paymentchannelaccountpara/create";
	}

	@ApiOperation("添加支付渠道")
    @RequiresPermissions("pattern:paymentchannelaccount:create")
    @RequestMapping(value = "/create",method = RequestMethod.POST)
	public @ResponseBody Object create(PaymentChannelAccountPara paymentChannelAccountPara) {
		ComplexResult result = valid(paymentChannelAccountPara);
		if (!result.isSuccess()) {
            return ResultUtils.buildErrorMsg(Constants.FAIL_MSG_CODE, result.getErrors());
        }
		ModelResult<Integer> modelResult = paymentChannelAccountParaServiceClinet.insertSelective(paymentChannelAccountPara);
		return ResultUtils.buildResult(modelResult);
	}

	
	@ApiOperation("编辑支付渠道账号参数")
    @RequiresPermissions("pattern:paymentchannelaccountpara:update")
    @RequestMapping(value = "/update/{paymentChannelAccountParaId}",method = RequestMethod.GET)
	public String update(@PathVariable("paymentChannelAccountParaId")Integer paymentChannelAccountParaId,ModelMap modelMap) {
		ModelResult<PaymentChannelAccountPara> modelResult = paymentChannelAccountParaServiceClinet.selectByPrimaryKey(paymentChannelAccountParaId);
		if(!modelResult.isSuccess()) {
			throw new NullPointerException("查询失败");
		}
		modelMap.put("paymentChannelAccountPara", modelResult.getModel());
		return "/manager/paymentchannelaccountpara/update";
	}

	@ApiOperation("添加支付渠道")
    @RequiresPermissions("pattern:paymentchannelaccount:update")
    @RequestMapping(value = "/update",method = RequestMethod.POST)
	public @ResponseBody Object update(PaymentChannelAccountPara paymentChannelAccountPara) {
		ComplexResult result = valid(paymentChannelAccountPara);
		if (!result.isSuccess()) {
            return ResultUtils.buildErrorMsg(Constants.FAIL_MSG_CODE, result.getErrors());
        }
		ModelResult<Integer> modelResult = paymentChannelAccountParaServiceClinet.updateByPrimaryKeySelective(paymentChannelAccountPara);
		return ResultUtils.buildResult(modelResult);
	}
	
	private ComplexResult valid(PaymentChannelAccountPara PaymentChannelAccountPara) {
		ComplexResult result = FluentValidator.checkAll()
	            .on(PaymentChannelAccountPara.getName(), new NotBlankValidator("参数名称"))
	            .on(PaymentChannelAccountPara.getValue(), new NotBlankValidator("参数值"))
	            .on(PaymentChannelAccountPara.getRemark(), new NotBlankValidator("备注"))
	            .doValidate()
	            .result(ResultCollectors.toComplex());
		return result;
	}
	
}
