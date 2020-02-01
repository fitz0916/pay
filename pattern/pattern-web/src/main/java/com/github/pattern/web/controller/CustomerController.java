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
import com.github.appmodel.domain.result.ResultUtils;
import com.github.appmodel.vo.PageVo;
import com.github.pattern.client.service.CustomerServiceClient;
import com.github.pattern.client.service.ShopServiceClient;
import com.github.pattern.common.domain.Customer;
import com.github.pattern.common.domain.Shop;
import com.github.pattern.common.request.CustomerRequest;
import com.github.pattern.utils.LengthValidator;

import io.swagger.annotations.ApiOperation;

@Controller
@RequestMapping("/manage/customer")
public class CustomerController {

	@Autowired
	private CustomerServiceClient customerServiceClient;
	
	@Autowired
	private ShopServiceClient shopServiceClient;
	
	
	
	
	@ApiOperation("商户首页")
    @RequiresPermissions("pattern:customer:read")
    @RequestMapping(value = "/index",method = RequestMethod.GET)
	public String index(ModelMap modelMap) {
		return "/manager/customer/index";
		
	}
	
	@ApiOperation("商户首页")
    @RequiresPermissions("pattern:customer:read")
    @RequestMapping(value = "/list",method = RequestMethod.POST)
	public @ResponseBody Object list(@RequestBody CustomerRequest request) {
		ModelResult<PageVo> modelResult = customerServiceClient.page(request);
		return ResultUtils.buildPageResult(modelResult);
		
	}
	
	@ApiOperation("添加商户")
    @RequiresPermissions("pattern:customer:create")
    @RequestMapping(value = "/create/{shopId}",method = RequestMethod.GET)
	public String create(@PathVariable("shopId")Integer shopId,ModelMap modelMap) {
		ModelResult<Shop> modelResult = shopServiceClient.selectByPrimaryKey(shopId);
		if(!modelResult.isSuccess()) {
			throw new NullPointerException("查询异常");
		}
		modelMap.put("shop", modelResult.getModel());
		return "/manager/customer/create";
	}
	
	@ApiOperation("添加商户")
    @RequiresPermissions("pattern:customer:create")
    @RequestMapping(value = "/create",method = RequestMethod.POST)
	public @ResponseBody Object create(Customer customer) {
		ComplexResult result = valid(customer);
		if (!result.isSuccess()) {
            return ResultUtils.buildErrorMsg(Constants.FAIL_MSG_CODE, result.getErrors());
        }
		ModelResult<Integer> modelResult = customerServiceClient.insertSelective(customer);
		return ResultUtils.buildResult(modelResult);
	}
	
	@ApiOperation("编辑商户")
    @RequiresPermissions("pattern:customer:update")
    @RequestMapping(value = "/update/{customerId}",method = RequestMethod.GET)
	public String update(@PathVariable("customerId")Integer customerId,ModelMap modelMap) {
		ModelResult<Customer> modelResult = customerServiceClient.selectByPrimaryKey(customerId);
		if(!modelResult.isSuccess()) {
			throw new NullPointerException("查询异常");
		}
		modelMap.put("customer", modelResult.getModel());
		return "/manager/customer/update";
	}
	
	@ApiOperation("编辑商户")
    @RequiresPermissions("pattern:customer:update")
    @RequestMapping(value = "/update",method = RequestMethod.POST)
	public @ResponseBody Object update(Customer customer) {
		ComplexResult result = valid(customer);
		if (!result.isSuccess()) {
            return ResultUtils.buildErrorMsg(Constants.FAIL_MSG_CODE, result.getErrors());
        }
		ModelResult<Integer> modelResult = customerServiceClient.updateByPrimaryKeySelective(customer);
		return ResultUtils.buildResult(modelResult);
	}
	
	private ComplexResult valid(Customer customer) {
		ComplexResult result = FluentValidator.checkAll()
	            .on(customer.getCustomerName(), new LengthValidator(5, 50, "商户名称"))
	            .doValidate()
	            .result(ResultCollectors.toComplex());
		return result;
		
	}
	
}
