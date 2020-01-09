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

import com.github.appmodel.domain.result.ModelResult;
import com.github.pattern.client.service.AgentServiceClient;
import com.github.pattern.client.service.ShopServiceClient;
import com.github.pattern.common.domain.Agent;
import com.github.pattern.common.domain.Shop;
import com.github.pattern.common.utils.ResultUtils;

import io.swagger.annotations.ApiOperation;

@Controller
@RequestMapping("/manage/shop")
public class ShopController {

	@Autowired
	private ShopServiceClient shopServiceClient;
	
	@Autowired
	private AgentServiceClient agentServiceClient;
	
	@ApiOperation("门店商首页")
    @RequiresPermissions("pattern:shop:read")
    @RequestMapping(value = "/list",method = RequestMethod.GET)
	public @ResponseBody Object list(@RequestParam("agentId") Integer agentId) {
		ModelResult<List<Shop>> modelResult = shopServiceClient.selectByAgentId(agentId);
		return ResultUtils.buildResult(modelResult);
	}
	
	@ApiOperation("门店商首页")
    @RequiresPermissions("pattern:shop:create")
    @RequestMapping(value = "/create/{agentId}",method = RequestMethod.GET)
	public String create(@PathVariable("agentId") Integer agentId,ModelMap modelMap) {
		ModelResult<Agent> modelResult = agentServiceClient.selectByPrimaryKey(agentId);
		if(!modelResult.isSuccess()) {
			throw new NullPointerException("查询异常");
		}
		modelMap.put("agent", modelResult.getModel());
		return "/manager/shop/create";
	}
}
