package com.github.admin.common.service;

import java.util.List;

import com.github.admin.common.domain.UserRole;
import com.github.appmodel.domain.result.ModelResult;

public interface UserRoleService {

	ModelResult<List<UserRole>> selectByUserId(Integer userId);

	ModelResult<Integer> role(String[] roleIds, Integer userId);

}
