package com.github.pattern.web.controller;

import java.util.List;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.appmodel.domain.result.ModelResult;
import com.github.pattern.client.service.PaymentTemplateServiceClient;
import com.github.pattern.common.domain.PaymentTemplate;
import com.github.pattern.common.utils.ResultUtils;

@Controller
@RequestMapping("/manage/paymenttemplate")
public class PaymentTemplateController {

	
	@Autowired
	private PaymentTemplateServiceClient paymentTemplateServiceClient;
	
	
	@RequiresPermissions("pattern:paymentchannel:create")
	@RequestMapping(value = "/list/{payType}",method = RequestMethod.POST)
	public @ResponseBody Object list(@PathVariable("payType")String payType) {
		ModelResult<List<PaymentTemplate>> modelResult = paymentTemplateServiceClient.selectByPayType(payType);
		return ResultUtils.buildResult(modelResult);
		
	}
	
}
