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
import com.github.pattern.client.service.BlackListServiceClient;
import com.github.pattern.common.domain.BlackList;
import com.github.pattern.common.request.BlackListRequest;
import com.github.pattern.common.utils.ResultUtils;
import com.github.pattern.common.vo.PageVo;
import com.github.pattern.utils.IPValidator;
import com.github.pattern.utils.NotNullValidator;

import io.swagger.annotations.ApiOperation;

@Controller
@RequestMapping("/manage/blacklist")
public class BlackListController {

	
	@Autowired
	private BlackListServiceClient blackListServiceClient;
	
	
	@ApiOperation("黑名单首页")
    @RequiresPermissions("pattern:blacklist:read")
    @RequestMapping(value = "/index",method = RequestMethod.GET)
	public String index(ModelMap modelMap) {
		return "/manager/blacklist/index";
		
	}
	
	@ApiOperation("黑名单首页")
    @RequiresPermissions("pattern:blacklist:read")
    @RequestMapping(value = "/list",method = RequestMethod.POST)
	public @ResponseBody Object list(@RequestBody BlackListRequest request) {
		ModelResult<PageVo> modelResult = blackListServiceClient.page(request);
		return ResultUtils.buildPageResult(modelResult);
		
	}
	
	@ApiOperation("添加黑名单")
    @RequiresPermissions("pattern:blacklist:create")
    @RequestMapping(value = "/create",method = RequestMethod.GET)
	public String create() {
		return "/manager/blacklist/create";
	}
	
	@ApiOperation("添加黑名单")
    @RequiresPermissions("pattern:blacklist:create")
    @RequestMapping(value = "/create",method = RequestMethod.POST)
	public @ResponseBody Object create(BlackList blackList) {
		ComplexResult result = valid(blackList);
		if (!result.isSuccess()) {
            return ResultUtils.buildErrorMsg(Constants.FAIL_MSG_CODE, result.getErrors());
        }
		ModelResult<Integer> modelResult = blackListServiceClient.insertSelective(blackList);
		return ResultUtils.buildResult(modelResult);
	}

	
	@ApiOperation("修改黑名单")
    @RequiresPermissions("pattern:blacklist:update")
    @RequestMapping(value = "/update/{blackListId}",method = RequestMethod.GET)
	public String update(@PathVariable("blackListId")Integer blackListId,ModelMap modelMap) {
		ModelResult<BlackList> modelResult = blackListServiceClient.selectByPrimaryKey(blackListId);
		if(!modelResult.isSuccess()) {
			throw new NullPointerException("查询异常");
		}
		modelMap.put("blackList", modelResult.getModel());
		return "/manager/blacklist/update";
	}
	
	@ApiOperation("编辑黑名单")
    @RequiresPermissions("pattern:blacklist:update")
    @RequestMapping(value = "/update",method = RequestMethod.POST)
	public @ResponseBody Object update(BlackList blackList) {
		ComplexResult result = valid(blackList);
		if (!result.isSuccess()) {
            return ResultUtils.buildErrorMsg(Constants.FAIL_MSG_CODE, result.getErrors());
        }
		ModelResult<Integer> modelResult = blackListServiceClient.updateByPrimaryKeySelective(blackList);
		return ResultUtils.buildResult(modelResult);
	}
	
	private ComplexResult valid(BlackList blackList) {
		ComplexResult result = FluentValidator.checkAll()
	            .on(blackList.getIp(), new IPValidator("黑名单IP"))
	            .on(blackList.getRemark(), new NotNullValidator("备注"))
	            .doValidate()
	            .result(ResultCollectors.toComplex());
		return result;
	}
	
}
