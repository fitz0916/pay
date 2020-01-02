package com.github.admin.client.service;

import java.util.List;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.github.admin.common.domain.UserOrganization;
import com.github.appmodel.domain.result.ModelResult;

@FeignClient(name="admin-server")
@RequestMapping("/admin/server/userOrganization")
public interface UserOrganizationServiceClient {

	@GetMapping("/organization/{insertSelective}/{userId}")
	ModelResult<Integer> insertSelective(@PathVariable("organizationIds")String[] organizationIds, @PathVariable("userId")Integer userId);
	
	@GetMapping("/selectByUserId/{userId}")
	public ModelResult<List<UserOrganization>> selectByUserId(@PathVariable("userId")Integer userId);
	
}
