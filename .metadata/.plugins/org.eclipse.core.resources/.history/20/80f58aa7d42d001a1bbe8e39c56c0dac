package com.github.admin.web.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.github.admin.common.domain.Permission;
import com.github.admin.common.service.PermissionService;
import com.github.appmodel.domain.result.ModelResult;

@RestController
@RequestMapping("/admin/server/permission")
public class PermissionController {

	@Autowired
	private PermissionService permissionServiceImpl;
	
	@GetMapping("/selectPermissionByUserId/{systemId}/{userId}")
	ModelResult<List<Permission>> selectPermissionByUserId(@PathVariable("systemId")Integer systemId, @PathVariable("userId")Integer userId){
		return permissionServiceImpl.selectPermissionByUserId(systemId,userId);
	}
}
