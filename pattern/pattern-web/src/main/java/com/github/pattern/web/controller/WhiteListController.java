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
import com.github.pattern.client.service.WhiteListServiceClient;
import com.github.pattern.common.domain.WhiteList;
import com.github.pattern.common.request.WhiteListRequest;
import com.github.pattern.utils.IPValidator;
import com.github.pattern.utils.NotNullValidator;

import io.swagger.annotations.ApiOperation;

@Controller
@RequestMapping("/manage/whitelist")
public class WhiteListController {
	
	@Autowired
	private WhiteListServiceClient whiteListServiceClient;
	
	@ApiOperation("白名单首页")
    @RequiresPermissions("pattern:whitelist:read")
    @RequestMapping(value = "/index",method = RequestMethod.GET)
	public String index(ModelMap modelMap) {
		return "/manager/whitelist/index";
		
	}
	
	@ApiOperation("白名单首页")
    @RequiresPermissions("pattern:whitelist:read")
    @RequestMapping(value = "/list",method = RequestMethod.POST)
	public @ResponseBody Object list(@RequestBody WhiteListRequest request) {
		ModelResult<PageVo> modelResult = whiteListServiceClient.page(request);
		return ResultUtils.buildPageResult(modelResult);
		
	}
	
	@ApiOperation("添加白名单")
    @RequiresPermissions("pattern:whitelist:create")
    @RequestMapping(value = "/create",method = RequestMethod.GET)
	public String create() {
		return "/manager/whitelist/create";
	}
	
	@ApiOperation("添加白名单")
    @RequiresPermissions("pattern:whitelist:create")
    @RequestMapping(value = "/create",method = RequestMethod.POST)
	public @ResponseBody Object create(WhiteList whiteList) {
		ComplexResult result = valid(whiteList);
		if (!result.isSuccess()) {
            return ResultUtils.buildErrorMsg(Constants.FAIL_MSG_CODE, result.getErrors());
        }
		ModelResult<Integer> modelResult = whiteListServiceClient.insertSelective(whiteList);
		return ResultUtils.buildResult(modelResult);
	}

	
	@ApiOperation("修改白名单")
    @RequiresPermissions("pattern:whitelist:update")
    @RequestMapping(value = "/update/{whiteListId}",method = RequestMethod.GET)
	public String update(@PathVariable("whiteListId")Integer whiteListId,ModelMap modelMap) {
		ModelResult<WhiteList> modelResult = whiteListServiceClient.selectByPrimaryKey(whiteListId);
		if(!modelResult.isSuccess()) {
			throw new NullPointerException("查询异常");
		}
		modelMap.put("whiteList", modelResult.getModel());
		return "/manager/whitelist/update";
	}
	
	@ApiOperation("编辑白名单")
    @RequiresPermissions("pattern:whitelist:update")
    @RequestMapping(value = "/update",method = RequestMethod.POST)
	public @ResponseBody Object update(WhiteList whiteList) {
		ComplexResult result = valid(whiteList);
		if (!result.isSuccess()) {
            return ResultUtils.buildErrorMsg(Constants.FAIL_MSG_CODE, result.getErrors());
        }
		ModelResult<Integer> modelResult = whiteListServiceClient.updateByPrimaryKeySelective(whiteList);
		return ResultUtils.buildResult(modelResult);
	}
	
	private ComplexResult valid(WhiteList whiteList) {
		ComplexResult result = FluentValidator.checkAll()
	            .on(whiteList.getIp(), new IPValidator("白名单IP"))
	            .on(whiteList.getRemark(), new NotNullValidator("备注"))
	            .doValidate()
	            .result(ResultCollectors.toComplex());
		return result;
	}
	

}
