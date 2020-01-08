package com.github.pattern.web.controller;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.appmodel.domain.result.ModelResult;
import com.github.pattern.client.service.ShopServiceClient;
import com.github.pattern.common.request.ShopRequest;
import com.github.pattern.common.utils.ResultUtils;
import com.github.pattern.common.vo.PageVo;

import io.swagger.annotations.ApiOperation;

@Controller
@RequestMapping("/manage/shop")
public class ShopController {

	@Autowired
	private ShopServiceClient shopServiceClient;
	
	@ApiOperation("门店商首页")
    @RequiresPermissions("pattern:shop:read")
    @RequestMapping(value = "/list",method = RequestMethod.GET)
	public @ResponseBody Object list(@RequestParam("agentId") Integer agentId) {
		ShopRequest request = new ShopRequest();
		request.setAgentId(agentId);
		ModelResult<PageVo> modelResult = shopServiceClient.page(request);
		return ResultUtils.buildPageResult(modelResult);
	}
	
	
}
