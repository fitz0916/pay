package com.github.pattern.web.controller;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pattern.common.utils.ResultUtils;
import com.github.appmodel.domain.result.ModelResult;
import com.github.pattern.client.service.AgentServiceClient;
import com.github.pattern.common.request.AgentRequest;
import com.github.pattern.common.vo.PageVo;

import io.swagger.annotations.ApiOperation;

@Controller
@RequestMapping("/manage/agent")
public class AgentController {

	@Autowired
	private AgentServiceClient agentServiceClient;
	
	@ApiOperation("代理商首页")
    @RequiresPermissions("pattern:agent:read")
    @RequestMapping(value = "/index",method = RequestMethod.GET)
    public String index(){
       return "/manager/agent/index";
    }
	
	public @ResponseBody Object list(@RequestBody AgentRequest request) {
		ModelResult<PageVo> modelResult = agentServiceClient.page(request);
		return ResultUtils.buildPageResult(modelResult);
	}
}
