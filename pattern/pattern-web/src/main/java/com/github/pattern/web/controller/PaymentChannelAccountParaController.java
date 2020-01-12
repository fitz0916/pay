package com.github.pattern.web.controller;

import java.util.List;
import java.util.Map;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.appmodel.domain.result.ModelResult;
import com.github.pattern.client.service.PaymentChannelAccountParaServiceClient;
import com.github.pattern.common.domain.PaymentChannelAccountPara;
import com.github.pattern.common.utils.ResultUtils;

import io.swagger.annotations.ApiOperation;

@Controller
@RequestMapping("/manage/paymentchannelaccountpara")
public class PaymentChannelAccountParaController {
	
	
	@Autowired
	private PaymentChannelAccountParaServiceClient paymentChannelAccountParaServiceClinet;
	
	
	
	@ApiOperation("支付渠道账号首页")
    @RequiresPermissions("pattern:paymentchannelaccountpara:read")
    @RequestMapping(value = "/list/{paymentChannelAccountId}",method = RequestMethod.POST)
	public @ResponseBody Object list(@PathVariable("paymentChannelAccountId")Integer paymentChannelAccountId) {
		ModelResult<List<PaymentChannelAccountPara>>  modelResult = paymentChannelAccountParaServiceClinet.selectByPaymentChannelAccountId(paymentChannelAccountId);
		return ResultUtils.buildResult(modelResult);
		
	}
	

}
