package com.github.admin.web.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.alibaba.fastjson.JSONArray;
import com.github.admin.common.service.UserPermissionService;
import com.github.appmodel.domain.result.ModelResult;

@RestController
@RequestMapping("/admin/server/userPermission")
public class UserPermissionController {

	@Autowired
	private UserPermissionService userPermissionServiceImpl;
	
	@PostMapping("/permission")
	public ModelResult<Integer> permission(@RequestBody JSONArray datas, @RequestParam("userId")Integer userId) {
		return userPermissionServiceImpl.permission(datas,userId);
	}
}
