package com.github.admin.web.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.github.admin.common.domain.UserOrganization;
import com.github.admin.common.service.UserOrganizationService;
import com.github.appmodel.domain.result.ModelResult;

@RestController
@RequestMapping("/admin/server/userOrganization")
public class UserOrganizationController {

	@Autowired	
	private UserOrganizationService userOrganizationServiceImpl;
	
	
	@GetMapping("/organization/insertSelective/{organizationIds}/{userId}")
	ModelResult<Integer> insertSelective(@PathVariable("organizationIds")String[] organizationIds, @PathVariable("userId")Integer userId){
		return userOrganizationServiceImpl.insertSelective(organizationIds,userId);
	}

	@GetMapping("/selectByUserId/{userId}")
	public ModelResult<List<UserOrganization>> selectByUserId(@PathVariable("userId")Integer userId){
		return userOrganizationServiceImpl.selectByUserId(userId);
		
	}
	
}
