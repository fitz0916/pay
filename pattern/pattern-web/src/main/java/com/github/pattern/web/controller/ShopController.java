package com.github.pattern.web.controller;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.baidu.unbiz.fluentvalidator.ComplexResult;
import com.baidu.unbiz.fluentvalidator.FluentValidator;
import com.baidu.unbiz.fluentvalidator.ResultCollectors;
import com.github.admin.common.constants.Constants;
import com.github.appmodel.domain.result.ModelResult;
import com.github.pattern.client.service.AgentServiceClient;
import com.github.pattern.client.service.ShopServiceClient;
import com.github.pattern.common.domain.Agent;
import com.github.pattern.common.domain.Shop;
import com.github.pattern.common.request.ShopRequest;
import com.github.pattern.common.utils.ResultUtils;
import com.github.pattern.common.vo.PageVo;
import com.github.pattern.utils.LengthValidator;
import com.github.pattern.utils.PhoneValidator;

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
    @RequestMapping(value = "/list",method = RequestMethod.POST)
	public @ResponseBody Object list(@RequestBody ShopRequest request) {
		ModelResult<PageVo> modelResult = shopServiceClient.page(request);
		return ResultUtils.buildPageResult(modelResult);
	}
	
	@ApiOperation("新增门店")
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
	
	@ApiOperation("添加")
    @RequiresPermissions("pattern:shop:create")
    @RequestMapping(value = "/create",method = RequestMethod.POST)
	public @ResponseBody Object create(Shop shop) {
		ComplexResult result = valid(shop);
		if (!result.isSuccess()) {
            return ResultUtils.buildErrorMsg(Constants.FAIL_MSG_CODE, result.getErrors());
        }
		ModelResult<Integer> modelResult = shopServiceClient.insertSelective(shop);
		return ResultUtils.buildResult(modelResult);
	}
	
	
	
	@ApiOperation("编辑门店")
    @RequiresPermissions("pattern:shop:update")
    @RequestMapping(value = "/update/{shopId}",method = RequestMethod.GET)
	public String update(@PathVariable("shopId") Integer shopId,ModelMap modelMap) {
		ModelResult<Shop> modelResult = shopServiceClient.selectByPrimaryKey(shopId);
		if(!modelResult.isSuccess()) {
			throw new NullPointerException("查询异常");
		}
		modelMap.put("shop", modelResult.getModel());
		return "/manager/shop/update";
	}
	
	@ApiOperation("编辑")
    @RequiresPermissions("pattern:shop:update")
    @RequestMapping(value = "/update",method = RequestMethod.POST)
	public @ResponseBody Object update(Shop shop) {
		ComplexResult result = valid(shop);
		if (!result.isSuccess()) {
            return ResultUtils.buildErrorMsg(Constants.FAIL_MSG_CODE, result.getErrors());
        }
		ModelResult<Integer> modelResult = shopServiceClient.updateByPrimaryKeySelective(shop);
		return ResultUtils.buildResult(modelResult);
	}
	
	private ComplexResult valid(Shop shop) {
		ComplexResult result = FluentValidator.checkAll()
	            .on(shop.getShopName(), new LengthValidator(1, 50, "门店名称"))
	            .on(shop.getBrand(), new LengthValidator(1, 50, "门店品牌"))
	            .on(shop.getAddress(), new LengthValidator(1, 50, "门店地址"))
	            .on(shop.getPhone(), new PhoneValidator("手机号码"))
	            .doValidate()
	            .result(ResultCollectors.toComplex());
		return result;
		
	}
}
