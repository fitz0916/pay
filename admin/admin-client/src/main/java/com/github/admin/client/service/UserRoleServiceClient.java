package com.github.admin.client.service;

import java.util.List;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.github.admin.common.domain.UserRole;
import com.github.appmodel.domain.result.ModelResult;

@FeignClient(name="admin-server")
@RequestMapping("/admin/server/userRole")
public interface UserRoleServiceClient {

	@GetMapping("/selectByUserId/{userId}")
	ModelResult<List<UserRole>> selectByUserId(@PathVariable("userId") Integer userId);

	@GetMapping("/role/{roleIds}/{userId}")
	ModelResult<Integer> role(@PathVariable("roleIds")String[] roleIds, @PathVariable("userId")Integer userId);

}
