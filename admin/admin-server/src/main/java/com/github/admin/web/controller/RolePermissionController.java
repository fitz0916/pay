package com.github.admin.web.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.alibaba.fastjson.JSONArray;
import com.github.admin.common.service.RolePermissionService;
import com.github.appmodel.domain.result.ModelResult;

@RestController
@RequestMapping("/admin/server/rolePermission")
public class RolePermissionController {
	
	@Autowired
	private RolePermissionService rolePermissionServiceImpl;
	
	@PostMapping("/rolePermission")
	ModelResult<Integer> rolePermission(@RequestBody JSONArray datas,@RequestParam("roleId")Integer roleId){
		return rolePermissionServiceImpl.rolePermission(datas,roleId);
	}
}
