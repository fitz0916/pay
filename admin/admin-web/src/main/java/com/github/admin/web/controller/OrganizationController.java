package com.github.admin.web.controller;

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
import com.github.admin.client.service.OrganizationServiceClient;
import com.github.admin.common.constants.Constants;
import com.github.admin.common.domain.Organization;
import com.github.admin.common.request.OrganizationRequest;
import com.github.admin.utils.LengthValidator;
import com.github.appmodel.domain.result.ModelResult;
import com.github.appmodel.domain.result.ResultUtils;
import com.github.appmodel.vo.PageVo;

import io.swagger.annotations.ApiOperation;

@Controller
@RequestMapping("/manage/organization")
public class OrganizationController {

	@Autowired
	private OrganizationServiceClient organizationServiceClient;
	
	 @ApiOperation("组织首页")
     @RequiresPermissions("admin:organization:read")
     @RequestMapping(value = "/index",method = RequestMethod.GET)
     public String index(){
        return "/manager/organization/index";
     }
	 
	
	@ApiOperation("组织列表")
    @RequiresPermissions("admin:organization:read")
    @RequestMapping(value = "/list",method = RequestMethod.POST)
    @ResponseBody
    public Object list(@RequestBody OrganizationRequest organizationRequest) {
        ModelResult<PageVo> modelResult = organizationServiceClient.pageOrganizationList(organizationRequest);
        return ResultUtils.buildPageResult(modelResult);
    }
	
	@ApiOperation("增加组织页")
    @RequiresPermissions("admin:organization:create")
    @RequestMapping(value = "/create", method = RequestMethod.GET)
    public String create(){
        return "/manager/organization/create";
    }
	
 	@ApiOperation("增加组织")
    @RequiresPermissions("admin:organization:create")
    @RequestMapping(value = "/create", method = RequestMethod.POST)
    @ResponseBody
    public Object create(Organization organization){
        ComplexResult result = FluentValidator.checkAll()
                .on(organization.getName(),new LengthValidator(1,20,"组织名"))
                .on(organization.getDescription(),new LengthValidator(1,30,"描述"))
                .doValidate()
                .result(ResultCollectors.toComplex());

        if (!result.isSuccess()) {
        	return ResultUtils.buildErrorMsg(Constants.FAIL_MSG_CODE, result.getErrors());
        }
        organization.setParentId(0);
        ModelResult<Integer> modelResult = organizationServiceClient.insertSelective(organization);
        return ResultUtils.buildResult(modelResult);
    }
 	
 	 @ApiOperation("修改组织页")
     @RequiresPermissions("admin:organization:update")
     @RequestMapping(value = "/update/{id}", method = RequestMethod.GET)
     public String update(@PathVariable("id") int id, ModelMap modelMap) {
         ModelResult<Organization> modelResult = organizationServiceClient.selectByPrimaryKey(id);
         if(modelResult.isSuccess()) {
        	 modelMap.put("organization", modelResult.getModel());
             return "/manager/organization/update";
         }else {
        	 throw new  NullPointerException(modelResult.getErrorMsg());
         }
         
     }
	
 	 
 	@ApiOperation("修改组织信息")
    @RequiresPermissions("admin:user:update")
    @RequestMapping(value = "/update/{id}", method = RequestMethod.POST)
    @ResponseBody
    public Object update(@PathVariable("id") int id, Organization organization) {
        ComplexResult result = FluentValidator.checkAll()
                .on(organization.getName(),new LengthValidator(1,20,"组织名"))
                .on(organization.getDescription(),new LengthValidator(1,30,"描述"))
                .doValidate()
                .result(ResultCollectors.toComplex());
        if (!result.isSuccess()) {
        	return ResultUtils.buildErrorMsg(Constants.FAIL_MSG_CODE, result.getErrors());
        }
        organization.setOrganizationId(id);
        ModelResult<Integer> modelResult =  organizationServiceClient.updateByPrimaryKeySelective(organization);
        return ResultUtils.buildResult(modelResult);
    }
 	
 	/**
     * 删除组织
     * @param ids
     * @return
     */
    @ApiOperation("删除组织")
    @RequiresPermissions("admin:organization:delete")
    @RequestMapping(value = "/delete/{ids}",method = RequestMethod.GET)
    @ResponseBody
    public Object delete(@PathVariable("ids") String ids) {
        ModelResult<Integer> modelResult = organizationServiceClient.deleteByPrimaryKeys(ids);
        return ResultUtils.buildResult(modelResult);
    }
}
