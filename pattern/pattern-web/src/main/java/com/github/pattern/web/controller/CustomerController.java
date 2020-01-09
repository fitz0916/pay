package com.github.pattern.web.controller;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.appmodel.domain.result.ModelResult;
import com.github.pattern.client.service.CustomerServiceClient;
import com.github.pattern.common.request.CustomerRequest;
import com.github.pattern.common.utils.ResultUtils;
import com.github.pattern.common.vo.PageVo;

import io.swagger.annotations.ApiOperation;

@Controller
@RequestMapping("/manage/customer")
public class CustomerController {

	@Autowired
	private CustomerServiceClient customerServiceClient;
	
	@ApiOperation("商户首页")
    @RequiresPermissions("pattern:customer:read")
    @RequestMapping(value = "/index/{shopId}",method = RequestMethod.GET)
	public String index(@PathVariable("shopId")Integer shopId,ModelMap modelMap) {
		modelMap.put("shopId", shopId);
		return "/manager/customer/index";
		
	}
	
	@ApiOperation("商户首页")
    @RequiresPermissions("pattern:customer:read")
    @RequestMapping(value = "/list",method = RequestMethod.POST)
	public @ResponseBody Object list(@RequestBody CustomerRequest request) {
		ModelResult<PageVo> modelResult = customerServiceClient.page(request);
		return ResultUtils.buildPageResult(modelResult);
		
	}
	
}
