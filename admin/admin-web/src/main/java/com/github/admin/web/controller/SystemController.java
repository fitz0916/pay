package com.github.admin.web.controller;

import java.util.Date;
import java.util.List;

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
import com.github.admin.client.service.SystemServiceClient;
import com.github.admin.common.domain.System;
import com.github.admin.common.request.SystemRequest;
import com.github.admin.common.utils.ResultUtils;
import com.github.admin.common.vo.PageVo;
import com.github.admin.utils.LengthValidator;
import com.github.appmodel.domain.result.ModelResult;

import io.swagger.annotations.ApiOperation;

@Controller
@RequestMapping("/manage/system")
public class SystemController {

	
	@Autowired
	private SystemServiceClient systemServiceClient;
	
	@ApiOperation("系统首页")
	@RequiresPermissions("admin:system:read")
	@RequestMapping(value = "/index", method = RequestMethod.GET)
	public String index() {
		return "/manager/system/index";
	}
	
	@ApiOperation("系统列表")
	@RequiresPermissions("admin:system:read")
	@RequestMapping(value = "/list", method = RequestMethod.POST)
	@ResponseBody
	public Object list(@RequestBody SystemRequest systemRequest) {
		ModelResult<PageVo> modelResult = systemServiceClient.pageSystemList(systemRequest);
		return ResultUtils.buildPageResult(modelResult);
	}
	
	@ApiOperation("增加系统页")
	@RequiresPermissions("admin:system:create")
	@RequestMapping(value = "/create", method = RequestMethod.GET)
	public String create() {
		return "/manager/system/create";
	}
	
	@ApiOperation("增加系统")
	@RequiresPermissions("admin:system:create")
	@RequestMapping(value = "/create", method = RequestMethod.POST)
	@ResponseBody
	public Object create(System system) {
		//这需要添加验证,公司maven依赖不下来百度验证框架
		ComplexResult result = FluentValidator.checkAll()
				.on(system.getTitle(), new LengthValidator(1, 20, "标题"))
				.on(system.getName(), new LengthValidator(1, 20, "名称"))
				.doValidate()
				.result(ResultCollectors.toComplex());
		if (!result.isSuccess()) {
			return ResultUtils.buildErrorMsg("10001", result.getErrors());
		}
		Date date = new Date();
		system.setUpdateTime(date);
		system.setCreateTime(date);
		return ResultUtils.buildResult(systemServiceClient.insertSelective(system));
	}
	
	@ApiOperation("删除系统")
	@RequiresPermissions("admin:system:delete")
	@RequestMapping(value = "/delete/{ids}",method = RequestMethod.GET)
	@ResponseBody
	public Object delete(@PathVariable("ids") String ids) {
		ModelResult<Integer> modelResult = systemServiceClient.deleteByPrimaryKey(ids);
		return ResultUtils.buildResult(modelResult);
	}
	
	@ApiOperation("修改系统页")
	@RequiresPermissions("admin:system:update")
	@RequestMapping(value = "/update/{id}", method = RequestMethod.GET)
	public String update(@PathVariable("id") int id, ModelMap modelMap) {
		ModelResult<System> modelResult = systemServiceClient.selectByPrimaryKey(id);
		if(modelResult.isSuccess()) {
			System system = modelResult.getModel();
			modelMap.put("system", system);
			return "/manager/system/update";
		}else {
			throw new NullPointerException(modelResult.getErrorMsg());
		}
		
	}
	
	
	@ApiOperation("修改系统")
	@RequiresPermissions("admin:system:update")
	@RequestMapping(value = "/update/{id}", method = RequestMethod.POST)
	@ResponseBody
	public Object update(@PathVariable("id") int id, System system) {
		ComplexResult result = FluentValidator.checkAll()
				.on(system.getTitle(), new LengthValidator(1, 20, "标题"))
				.on(system.getName(), new LengthValidator(1, 20, "名称"))
				.doValidate()
				.result(ResultCollectors.toComplex());
		if (!result.isSuccess()) {
			return ResultUtils.buildErrorMsg("10001", result.getErrors());
		}
		system.setSystemId(id);
		ModelResult<Integer> modelResult = systemServiceClient.updateByPrimaryKeySelective(system);
		return ResultUtils.buildResult(modelResult);
	}
	
	@ApiOperation("查找所有系统列表")
	@RequiresPermissions("admin:system:read")
	@RequestMapping(value = "/all",method = RequestMethod.GET)
	@ResponseBody
	public Object list(){
		ModelResult<List<System>> modelResult = systemServiceClient.querySystemByStatus(1);
		return ResultUtils.buildResult(modelResult);
	}
}
