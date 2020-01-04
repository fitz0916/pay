package com.github.admin.web.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSONArray;
import com.baidu.unbiz.fluentvalidator.ComplexResult;
import com.baidu.unbiz.fluentvalidator.FluentValidator;
import com.baidu.unbiz.fluentvalidator.ResultCollectors;
import com.github.admin.client.service.OrganizationServiceClient;
import com.github.admin.client.service.RoleServiceClient;
import com.github.admin.client.service.UserOrganizationServiceClient;
import com.github.admin.client.service.UserPermissionServiceClient;
import com.github.admin.client.service.UserRoleServiceClient;
import com.github.admin.client.service.UserServiceClient;
import com.github.admin.common.constants.Constants;
import com.github.admin.common.domain.Organization;
import com.github.admin.common.domain.Role;
import com.github.admin.common.domain.User;
import com.github.admin.common.domain.UserInfo;
import com.github.admin.common.domain.UserOrganization;
import com.github.admin.common.domain.UserRole;
import com.github.admin.common.request.UserRequest;
import com.github.admin.common.utils.MD5Utils;
import com.github.admin.common.utils.ResultUtils;
import com.github.admin.common.vo.PageVo;
import com.github.admin.utils.LengthValidator;
import com.github.admin.utils.RedisUtils;
import com.github.appmodel.domain.result.ModelResult;
import com.github.appmodel.page.DataPage;

import io.swagger.annotations.ApiOperation;

@Controller
@RequestMapping("/manage/user")
public class UserController {

		
		@Autowired
		private UserServiceClient userServiceClient;	
		
		@Autowired
		private OrganizationServiceClient organizationServiceClient;
		
		@Autowired
		private UserOrganizationServiceClient userOrganizationServiceClient;
		
		@Autowired
		private RoleServiceClient roleServiceClient;
		
		@Autowired
		private UserRoleServiceClient userRoleServiceClient;
		
		@Autowired
		private RedisUtils redisUtils;
		
		@Autowired
		private UserPermissionServiceClient userPermissionServiceClient;
		
		@ApiOperation("用户首页")
	    @RequiresPermissions("admin:user:read")
	    @RequestMapping(value = "/index",method = RequestMethod.GET)
	    public String index(){
	        return "/manager/user/index";
	    }
		
		
		@ApiOperation("查看用户列表")
	    @RequiresPermissions("admin:user:read")
	    @RequestMapping(value = "/list", method = RequestMethod.POST)
	    @ResponseBody
	    public Object list(@RequestBody UserRequest userRequest) {
	        ModelResult<PageVo> modelResult = userServiceClient.pageUserInfoList(userRequest);
	        return ResultUtils.buildPageResult(modelResult);
	      }
		
		    @ApiOperation("增加用户页")
		    @RequiresPermissions("admin:user:create")
		    @RequestMapping(value = "/create", method = RequestMethod.GET)
		    public String create() {
		        return "/manager/user/create";
		    }
		    
		    @ApiOperation("新增用户")
		    @RequiresPermissions("admin:user:create")
		    @RequestMapping(value = "/create", method = RequestMethod.POST)
		    @ResponseBody
		    public Object create(User user){
		      ComplexResult result = FluentValidator.checkAll()
		                .on(user.getUserName(),new LengthValidator(1,20,"账号"))
		                .on(user.getPassword(),new LengthValidator(1,20,"密码"))
		                .on(user.getRealName(),new LengthValidator(1,20,"姓名"))
		                .doValidate()
		                .result(ResultCollectors.toComplex());

		        if (!result.isSuccess()) {
		            return ResultUtils.buildErrorMsg(Constants.FAIL_MSG_CODE, result.getErrors());
		        }
		        String salt = UUID.randomUUID().toString().replace("-","");
		        user.setSalt(salt.toUpperCase());
		        user.setPassword(MD5Utils.md5(user.getPassword(),user.getSalt()));
		        ModelResult<Integer> modelResult = userServiceClient.insertSelective(user);
		        return ResultUtils.buildResult(modelResult);
		    }
		  
		    @ApiOperation("修改用户信息")
		    @RequiresPermissions("admin:user:update")
		    @RequestMapping(value = "/update/{id}", method = RequestMethod.GET)
		    public String update(@PathVariable("id") int id,ModelMap modelMap) {
		    	ModelResult<User> modelResult = userServiceClient.selectByPrimaryKey(id);
		    	if(modelResult.isSuccess()) {
		    		User user = modelResult.getModel();
		    		 modelMap.put("user", user);
				     return "/manager/user/update";
		    	}else {
		    		throw new NullPointerException(modelResult.getErrorMsg());
		    	}
		    }
		    
		    @ApiOperation("修改用户信息")
		    @RequiresPermissions("admin:user:update")
		    @RequestMapping(value = "/update/{id}", method = RequestMethod.POST)
		    @ResponseBody
		    public Object update(@PathVariable("id") int id, User user) {
		        ComplexResult result = FluentValidator.checkAll()
		                .on(user.getUserName(), new LengthValidator(1,20, "帐号"))
		                .on(user.getRealName(), new LengthValidator(1,20,"姓名"))
		                .doValidate()
		                .result(ResultCollectors.toComplex());
		        if (!result.isSuccess()) {
		        	return ResultUtils.buildErrorMsg(Constants.FAIL_MSG_CODE, result.getErrors());
		        }
		        // 不允许直接改密码
		        user.setPassword(null);
		        user.setUserId(id);
		        ModelResult<Integer> modelResult =  userServiceClient.updateByPrimaryKey(user);
		        return ResultUtils.buildResult(modelResult);
		    }
		    
		    @ApiOperation("删除用户")
		    @RequiresPermissions("admin:user:delete")
		    @RequestMapping(value = "/delete/{ids}",method = RequestMethod.GET)
		    @ResponseBody
		    public Object delete(@PathVariable("ids") String ids) {
		    	ModelResult<Integer> modelResult =  userServiceClient.deleteByPrimaryKey(ids);
		    	return ResultUtils.buildResult(modelResult);
		    }
		    
		    @ApiOperation("用户组织页")
		    @RequiresPermissions("admin:user:organization")
		    @RequestMapping(value = "/organization/{id}", method = RequestMethod.GET)
		    public String organization(@PathVariable("id") int id, ModelMap modelMap) {
		        // 所有组织
		        ModelResult<List<Organization>> organizationModelResult = organizationServiceClient.allOrganizationList();
		        List<Organization> organizations = new ArrayList<Organization>();
		        List<UserOrganization> userOrganizations = new ArrayList<UserOrganization>();
		        if(!organizationModelResult.isSuccess()) {
		        	throw new NullPointerException("查询组织异常");
		        }
		        organizations = organizationModelResult.getModel();
		        // 用户拥有组织
		        ModelResult<List<UserOrganization>> modelResult = userOrganizationServiceClient.selectByUserId(id);
		        if(!modelResult.isSuccess()) {
		        	throw new NullPointerException("查询用户组织异常");
		        }
		        userOrganizations = modelResult.getModel();
		        modelMap.put("organizations", organizations);
		        modelMap.put("userOrganizations", userOrganizations);
		        return "/manager/user/organization";
		    }
		    
		    @ApiOperation("修改用户组织")
		    @RequiresPermissions("admin:user:organization")
		    @RequestMapping(value = "/organization/{id}", method = RequestMethod.POST)
		    @ResponseBody
		    public Object organization(@PathVariable("id") int id, HttpServletRequest request) {
		        String[] organizationIds = request.getParameterValues("organizationId");
		        ModelResult<Integer>  modelResult = userOrganizationServiceClient.insertSelective(organizationIds, id);
		        return ResultUtils.buildResult(modelResult);
		    }
		    
		    @ApiOperation("用户角色")
		    @RequiresPermissions("admin:user:role")
		    @RequestMapping(value = "/role/{id}", method = RequestMethod.GET)
		    public String role(@PathVariable("id") int id, ModelMap modelMap) {
		        // 所有角色
		        ModelResult<List<Role>> roleModelResult = roleServiceClient.allRolesList();
		        if(!roleModelResult.isSuccess()) {
		        	throw new NullPointerException("查询角色异常");
		        }
		        // 用户拥有角色
		        ModelResult<List<UserRole>> modelResult = userRoleServiceClient.selectByUserId(id);
		        if(!modelResult.isSuccess()) {
		        	throw new NullPointerException("查询用户角色异常");
		        }
		        List<Role> roles = roleModelResult.getModel();
		        List<UserRole> userRoles = modelResult.getModel();
		        modelMap.put("roles", roles);
		        modelMap.put("userRoles", userRoles);
		        return "/manager/user/role";
		    }

		    /**
		     * 用户角色
		     * @param id
		     * @param request
		     * @return
		     */
		    @ApiOperation("修改用户角色")
		    @RequiresPermissions("admin:user:role")
		    @RequestMapping(value = "/role/{id}", method = RequestMethod.POST)
		    @ResponseBody
		    public Object role(@PathVariable("id") int id, HttpServletRequest request) {
		        String[] roleIds = request.getParameterValues("roleId");
		        ModelResult<Integer> modelResult = userRoleServiceClient.role(roleIds, id);
		        return ResultUtils.buildResult(modelResult);
		    }
		    
		    /**
		     * 用户权限
		     * @param id
		     * @param modelMap
		     * @return
		     */
		    @ApiOperation("进入用户权限页")
		    @RequiresPermissions("admin:user:permission")
		    @RequestMapping(value = "/permission/{id}", method = RequestMethod.GET)
		    public String permission(@PathVariable("id") int id, ModelMap modelMap) {
		        ModelResult<User> modelResult = userServiceClient.selectByPrimaryKey(id);
		        if(!modelResult.isSuccess()) {
		        	throw new NullPointerException("查询用户信息异常");
		        }
		        User user = modelResult.getModel();
	        	modelMap.put("user", user);
		        return "/manager/user/permission";
		        
		        
		    }

		    /**
		     * 用户权限
		     * @param id
		     * @param request
		     * @return
		     */
		    @ApiOperation("修改用户权限")
		    @RequiresPermissions("admin:user:permission")
		    @RequestMapping(value = "/permission/{id}", method = RequestMethod.POST)
		    @ResponseBody
		    public Object permission(@PathVariable("id") int id, HttpServletRequest request) {
		        JSONArray datas = JSONArray.parseArray(request.getParameter("datas"));
		        ModelResult<Integer> modelResult = userPermissionServiceClient.permission(datas, id);
		        return ResultUtils.buildResult(modelResult);
		    }
		    
//		    
//		    @ApiOperation("修改密码")
//		    @RequiresPermissions("admin:password:update")
//		    @RequestMapping(value = "/password/{userId}",method = RequestMethod.POST)
//		    @ResponseBody
//		    public Object password(@PathVariable("userId")Integer userId,
//		                           @RequestParam("newPassword")String newPassword,
//		                           @RequestParam("repeatPassword")String repeatPassword){
//		        if (!newPassword.equals(repeatPassword)){
//		            return ResultUtils.toJSONResult("输入密码不一致",false);
//		        }
//		        User user = userServiceClient.selectByPrimaryKey(userId);
//		        if (user == null){
//		        	return ResultUtils.toJSONResult("当前用户不存在",false);
//		        }
//		        String salt = UUID.randomUUID().toString().replace("-","");
//		        user.setSalt(salt.toUpperCase());
//		        user.setPassword(MD5Utils.md5(newPassword,user.getSalt()));
//		        userServiceClient.updateByPrimaryKey(user);
//		        return ResultUtils.toJSONResult(true);
//
//		    }
  }
