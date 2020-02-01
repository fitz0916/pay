package com.github.admin.common.service;

import com.github.admin.common.domain.User;
import com.github.admin.common.request.UserRequest;
import com.github.appmodel.domain.result.ModelResult;
import com.github.appmodel.vo.PageVo;

public interface UserService {

	/***
	 * 根据账号名称查询账号
	 * @param userName
	 * @return
	 */
	ModelResult<User> selectUserByUserName(String userName);

	ModelResult<PageVo> pageUserInfoList(UserRequest userRequest);

	ModelResult<Integer> insertSelective(User user);

	ModelResult<User> selectByPrimaryKey(Integer userId);
	
	public ModelResult<Integer> updateByPrimaryKey(User user);

	public ModelResult<Integer> deleteByPrimaryKey(String ids);
}
