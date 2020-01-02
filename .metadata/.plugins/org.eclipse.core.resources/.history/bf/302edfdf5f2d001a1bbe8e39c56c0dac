package com.github.admin.web.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.github.admin.common.domain.Role;
import com.github.admin.common.service.RoleService;
import com.github.appmodel.domain.result.ModelResult;



@RestController
@RequestMapping("/admin/server/role")
public class RoleController {

	@Autowired
	private RoleService roleService;
	
	@GetMapping("/selectRoleByUserId/{userId}")
	ModelResult<List<Role>> selectRoleByUserId(@PathVariable("userId")Integer userId){
		return roleService.selectRoleByUserId(userId);
	}
}
