package com.github.pattern.web.controller;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.appmodel.domain.result.ModelResult;
import com.github.appmodel.domain.result.ResultUtils;
import com.github.appmodel.vo.PageVo;
import com.github.pattern.common.request.AgentRequest;
import com.github.trans.client.PaymentOrderServiceClient;
import com.github.trans.common.request.PaymentOrderRequest;

import io.swagger.annotations.ApiOperation;

@Controller
@RequestMapping("/manage/paymentorder")
public class PaymentOrderController {
	
	@Autowired
	private PaymentOrderServiceClient paymentOrderServiceClient;

	
	@ApiOperation("支付订单首页")
    @RequiresPermissions("pattern:paymentorder:read")
    @RequestMapping(value = "/index",method = RequestMethod.GET)
    public String index(){
       return "/manager/paymentorder/index";
    }
	
	
	@ApiOperation("支付订单首页")
    @RequiresPermissions("pattern:paymentorder:read")
    @RequestMapping(value = "/list",method = RequestMethod.POST)
	public @ResponseBody Object list(@RequestBody PaymentOrderRequest request) {
		ModelResult<PageVo> modelResult = paymentOrderServiceClient.page(request);
		return ResultUtils.buildPageResult(modelResult);
	}
	
}
