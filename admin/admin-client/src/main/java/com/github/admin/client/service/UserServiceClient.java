package com.github.admin.client.service;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.github.admin.common.domain.User;
import com.github.admin.common.request.UserRequest;
import com.github.admin.common.vo.PageVo;
import com.github.appmodel.domain.result.ModelResult;

@FeignClient(name="admin-server")
@RequestMapping("/admin/server/user")
public interface UserServiceClient {

	@GetMapping("/selectUserByUserName/{userName}")
	ModelResult<User> selectUserByUserName(@PathVariable("userName")String userName);

	@PostMapping("/pageUserInfoList")
	ModelResult<PageVo> pageUserInfoList(@RequestBody UserRequest userRequest);

	@PostMapping("/insertSelective")
	ModelResult<Integer> insertSelective(@RequestBody User user);

	@GetMapping("/selectByPrimaryKey/{userId}")
	ModelResult<User> selectByPrimaryKey(@PathVariable("userId") Integer userId);

	@PostMapping("/updateByPrimaryKey")
	ModelResult<Integer> updateByPrimaryKey(@RequestBody User user);

	@PostMapping("/deleteByPrimaryKey/{ids}")
	ModelResult<Integer> deleteByPrimaryKey(@PathVariable("ids") String ids);

}
