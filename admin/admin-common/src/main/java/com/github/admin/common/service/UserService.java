package com.github.admin.common.service;

import com.github.admin.common.domain.User;
import com.github.appmodel.domain.result.ModelResult;

public interface UserService {

	/***
	 * 根据账号名称查询账号
	 * @param userName
	 * @return
	 */
	ModelResult<User> selectUserByUserName(String userName);
}
