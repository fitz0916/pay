package com.github.admin.web.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.alibaba.fastjson.JSONArray;
import com.github.admin.common.domain.Permission;
import com.github.admin.common.domain.PermissionInfo;
import com.github.admin.common.service.PermissionService;
import com.github.admin.common.vo.PageVo;
import com.github.appmodel.domain.result.ModelResult;
import com.github.appmodel.page.DataPage;

@RestController
@RequestMapping("/admin/server/permission")
public class PermissionController {

	@Autowired
	private PermissionService permissionServiceImpl;
	
	@GetMapping("/selectPermissionByUserId/{systemId}/{userId}")
	ModelResult<List<Permission>> selectPermissionByUserId(@PathVariable("systemId")Integer systemId, @PathVariable("userId")Integer userId){
		return permissionServiceImpl.selectPermissionByUserId(systemId,userId);
	}
	
	@PostMapping("/pagePermissionInfoList")
	ModelResult<PageVo> pagePermissionInfoList(@RequestBody DataPage<PermissionInfo> dataPage){
		return permissionServiceImpl.pagePermissionInfoList(dataPage);
	}
	
	@GetMapping("/getTreeByRoleId/{roleId}")
	public ModelResult<JSONArray> getTreeByRoleId(@PathVariable("roleId") Integer roleId){
		return permissionServiceImpl.getTreeByRoleId(roleId);
	}

	@GetMapping("/selectByPrimaryKey/{permissionId}")
	public ModelResult<Permission> selectByPrimaryKey(@PathVariable("permissionId")Integer permissionId){
		return permissionServiceImpl.selectByPrimaryKey(permissionId);
	}
	
	@GetMapping("/selectByParentId/{parentId}")
	public ModelResult<List<Permission>> selectByParentId(@PathVariable("parentId")Integer parentId){
		return permissionServiceImpl.selectByParentId(parentId);
	}

	@PostMapping("/updateByPrimaryKeySelective")
	public ModelResult<Integer> updateByPrimaryKeySelective(@RequestBody Permission permission){
		return permissionServiceImpl.updateByPrimaryKeySelective(permission);
	}

	@PostMapping("/insertSelective")
	public ModelResult<Integer> insertSelective(@RequestBody Permission permission){
		return permissionServiceImpl.insertSelective(permission);
	}

	@GetMapping("/getTreeByUserId/{userId}/{userPermissionType}")
	public ModelResult<JSONArray> getTreeByUserId(@PathVariable("userId")Integer userId, @PathVariable("userPermissionType")Integer userPermissionType){
		return permissionServiceImpl.getTreeByUserId(userId,userPermissionType);
	}
	
	@GetMapping("/deleteByPrimaryKeys/{ids}")
	public ModelResult<Integer> deleteByPrimaryKeys(String ids){
		return permissionServiceImpl.deleteByPrimaryKeys(ids);
	}
}
