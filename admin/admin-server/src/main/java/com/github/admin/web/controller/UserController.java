package com.github.admin.web.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.github.admin.common.domain.User;
import com.github.admin.common.service.UserService;
import com.github.appmodel.domain.result.ModelResult;

@RestController
@RequestMapping("/admin/server/user")
public class UserController {

	@Autowired
	private UserService userServiceImpl;
	
	
	@GetMapping("/selectUserByUserName/{userName}")
	ModelResult<User> selectUserByUserName(@PathVariable("userName")String userName){
		return userServiceImpl.selectUserByUserName(userName);
	}
}
