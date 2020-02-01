package com.github.admin.client.service;

import java.util.List;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.fastjson.JSONArray;
import com.github.admin.common.domain.Permission;
import com.github.admin.common.request.PermissionRequest;
import com.github.appmodel.domain.result.ModelResult;
import com.github.appmodel.vo.PageVo;

@FeignClient(name="admin-server")
@RequestMapping("/admin/server/permission")
public interface PermissionServiceClient {

	@GetMapping("/selectPermissionByUserId/{systemId}/{userId}")
	ModelResult<List<Permission>> selectPermissionByUserId(@PathVariable("systemId")Integer systemId, @PathVariable("userId")Integer userId);

	@PostMapping("/pagePermissionInfoList")
	ModelResult<PageVo> pagePermissionInfoList(@RequestBody PermissionRequest permissionRequest);
	
	@GetMapping("/getTreeByRoleId/{roleId}")
	public ModelResult<JSONArray> getTreeByRoleId(@PathVariable("roleId") Integer roleId);

	@GetMapping("/selectByPrimaryKey/{permissionId}")
	public ModelResult<Permission> selectByPrimaryKey(@PathVariable("permissionId")Integer permissionId);
	
	@GetMapping("/selectByParentId/{parentId}")
	public ModelResult<List<Permission>> selectByParentId(@PathVariable("parentId")Integer parentId);

	@PostMapping("/updateByPrimaryKeySelective")
	public ModelResult<Integer> updateByPrimaryKeySelective(@RequestBody Permission permission);

	@PostMapping("/insertSelective")
	public ModelResult<Integer> insertSelective(@RequestBody Permission permission);

	@GetMapping("/getTreeByUserId/{userId}/{userPermissionType}")
	public ModelResult<JSONArray> getTreeByUserId(@PathVariable("userId")Integer userId, @PathVariable("userPermissionType")Integer userPermissionType);
	
	@GetMapping("/deleteByPrimaryKeys/{ids}")
	public ModelResult<Integer> deleteByPrimaryKeys(@PathVariable("ids")String ids);

	@GetMapping("/selectBySystemId/{systemId}")
	ModelResult<List<Permission>> selectBySystemId(@PathVariable("systemId")Integer systemId);
	
	
	

}
