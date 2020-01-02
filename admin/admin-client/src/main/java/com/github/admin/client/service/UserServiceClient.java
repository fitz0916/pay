package com.github.admin.client.service;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.github.admin.common.domain.User;
import com.github.appmodel.domain.result.ModelResult;

@FeignClient(name="admin-server")
@RequestMapping("/admin/server/user")
public interface UserServiceClient {

	@GetMapping("/selectUserByUserName/{userName}")
	ModelResult<User> selectUserByUserName(@PathVariable("userName")String userName);

}
