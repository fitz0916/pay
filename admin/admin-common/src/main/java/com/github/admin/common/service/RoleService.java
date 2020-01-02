package com.github.admin.common.service;

import java.util.List;

import com.github.admin.common.domain.Role;
import com.github.appmodel.domain.result.ModelResult;

public interface RoleService {

	/***
	 * 根据userId查询角色
	 * @param userId
	 * @return
	 */
	public ModelResult<List<Role>> selectRoleByUserId(Integer userId);
}
