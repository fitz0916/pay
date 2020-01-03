package com.github.admin.web.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.alibaba.fastjson.JSONArray;
import com.baidu.unbiz.fluentvalidator.ComplexResult;
import com.baidu.unbiz.fluentvalidator.FluentValidator;
import com.baidu.unbiz.fluentvalidator.ResultCollectors;
import com.github.admin.client.service.RolePermissionServiceClient;
import com.github.admin.client.service.RoleServiceClient;
import com.github.admin.common.constants.Constants;
import com.github.admin.common.domain.Role;
import com.github.admin.common.utils.ResultUtils;
import com.github.admin.common.vo.PageVo;
import com.github.admin.utils.LengthValidator;
import com.github.appmodel.domain.result.ModelResult;
import com.github.appmodel.page.DataPage;

import io.swagger.annotations.ApiOperation;

@Controller
@RequestMapping("/manage/role")
public class RoleController {

	 	@Autowired
	    private RoleServiceClient roleServiceClient;
	    @Autowired
	    private RolePermissionServiceClient rolePermissionServiceClient;
	    
	    
	    /**
	     * 角色首页
	     * @return
	     */
	    @ApiOperation("角色首页")
	    @RequiresPermissions("admin:role:read")
	    @RequestMapping(value = "/index",method = RequestMethod.GET)
	    public String index(){
	        return "/manager/role/index";
	    }
	    
	    /**
	     * 角色列表
	     * @param offset
	     * @param limit
	     * @param search
	     * @param sort
	     * @param order
	     * @return
	     */
	    @ApiOperation("角色列表")
	    @RequiresPermissions("admin:role:read")
	    @RequestMapping(value = "/list",method = RequestMethod.GET)
	    @ResponseBody
	    public Object list(
	            @RequestParam(required = false, defaultValue = "0", value = "offset") int offset,
	            @RequestParam(required = false, defaultValue = "10", value = "limit") int limit,
	            @RequestParam(required = false, defaultValue = "", value = "search") String search,
	            @RequestParam(required = false, value = "sort") String sort,
	            @RequestParam(required = false, value = "order") String order) {
	        DataPage<Role> dataPage = new DataPage<Role>();
	        dataPage.setPageSize(limit);
	        dataPage.setPageNo(offset/limit+1);
	        ModelResult<PageVo> modelResult = roleServiceClient.pageRoleList(dataPage);
	        return ResultUtils.buildPageResult(modelResult);
	    }
	    @ApiOperation("查找所有角色列表")
	    @RequiresPermissions("admin:role:read")
	    @RequestMapping(value = "/all",method = RequestMethod.GET)
	    @ResponseBody
	    public Object list(){
	        ModelResult<List<Role>> modelResult = roleServiceClient.allRolesList();
	        if(!modelResult.isSuccess()) {
	        	throw new NullPointerException("查询角色异常");
	        }
	        List<Role> list = modelResult.getModel();
	        return list;
	    }

	    @ApiOperation("增加角色页")
	    @RequiresPermissions("admin:role:create")
	    @RequestMapping(value = "/create", method = RequestMethod.GET)
	    public String create(){
	        return "/manager/role/create";
	    }

	    /**
	     * 增加角色
	     * @param role
	     * @return
	     */
	    @ApiOperation("增加角色")
	    @RequiresPermissions("admin:role:create")
	    @RequestMapping(value = "/create", method = RequestMethod.POST)
	    @ResponseBody
	    public Object create(Role role){
	        ComplexResult result = FluentValidator.checkAll()
	                .on(role.getName(),new LengthValidator(1,20,"角色名"))
	                .on(role.getTitle(),new LengthValidator(1,30,"标题"))
	                .on(role.getDescription(),new LengthValidator(1,30,"描述"))
	                .doValidate()
	                .result(ResultCollectors.toComplex());

	        if (!result.isSuccess()) {
	            return ResultUtils.buildErrorMsg(Constants.FAIL_MSG_CODE, result.getErrors());
	        }
	        ModelResult<Integer> modelResult = roleServiceClient.insertSelective(role);
	        return ResultUtils.buildResult(modelResult);
	    }

	    @ApiOperation("修改角色页")
	    @RequiresPermissions("admin:role:update")
	    @RequestMapping(value = "/update/{id}", method = RequestMethod.GET)
	    public String update(@PathVariable("id") int id, ModelMap modelMap) {
	        ModelResult<Role> modelResult = roleServiceClient.selectByPrimaryKey(id);
	        if(!modelResult.isSuccess()) {
	        	throw new NullPointerException("查询角色异常");
	        }
	        modelMap.put("role", modelResult.getModel());
	        return "/manager/role/update";
	    }

	    /**
	     * 修改角色信息
	     * @param id
	     * @param role
	     * @return
	     */
	    @ApiOperation("修改角色")
	    @RequiresPermissions("admin:role:update")
	    @RequestMapping(value = "/update/{id}", method = RequestMethod.POST)
	    @ResponseBody
	    public Object update(@PathVariable("id") int id, Role role) {
	        ComplexResult result = FluentValidator.checkAll()
	                .on(role.getName(),new LengthValidator(1,20,"角色名"))
	                .on(role.getTitle(),new LengthValidator(1,30,"标题"))
	                .on(role.getDescription(),new LengthValidator(1,30,"描述"))
	                .doValidate()
	                .result(ResultCollectors.toComplex());
	        if (!result.isSuccess()) {
	        	return ResultUtils.buildErrorMsg(Constants.FAIL_MSG_CODE, result.getErrors());
	        }
	        role.setRoleId(id);
	        ModelResult<Integer> modelResult =  roleServiceClient.updateByPrimaryKeySelective(role);
	        return ResultUtils.buildResult(modelResult);
	    }

	    /**
	     * 批量删除角色
	     * @param ids
	     * @return
	     */
	    @ApiOperation("删除角色")
	    @RequiresPermissions("admin:role:delete")
	    @RequestMapping(value = "/delete/{ids}",method = RequestMethod.GET)
	    @ResponseBody
	    public Object delete(@PathVariable("ids") String ids) {
	        ModelResult<Integer> modelResult = roleServiceClient.deleteByPrimaryKeys(ids);
	        return ResultUtils.buildResult(modelResult);
	    }

	    /**
	     * 角色权限
	     * @param id
	     * @param modelMap
	     * @return
	     */
	    @ApiOperation("角色权限页")
	    @RequiresPermissions("admin:role:permission")
	    @RequestMapping(value = "/permission/{id}", method = RequestMethod.GET)
	    public String permission(@PathVariable("id") int id, ModelMap modelMap) {
	        ModelResult<Role> modelResult = roleServiceClient.selectByPrimaryKey(id);
	        if(!modelResult.isSuccess()) {
	        	throw new NullPointerException("查询角色异常");
	        }
	        modelMap.put("role", modelResult.getModel());
	        return "/manager/role/permission";
	    }
	    @ApiOperation("修改角色权限")
	    @RequiresPermissions("admin:role:permission")
	    @RequestMapping(value = "/permission/{id}", method = RequestMethod.POST)
	    @ResponseBody
	    public Object permission(@PathVariable("id") int id, HttpServletRequest request) {
	        JSONArray datas = JSONArray.parseArray(request.getParameter("datas"));
	        ModelResult<Integer> modelResult = rolePermissionServiceClient.rolePermission(datas, id);
	        return ResultUtils.buildResult(modelResult);
	    }
}
