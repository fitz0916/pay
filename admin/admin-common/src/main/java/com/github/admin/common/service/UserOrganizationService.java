package com.github.admin.common.service;

import java.util.List;

import com.github.admin.common.domain.UserOrganization;
import com.github.appmodel.domain.result.ModelResult;

public interface UserOrganizationService {

	ModelResult<Integer> insertSelective(String[] organizationIds, Integer userId);

	ModelResult<List<UserOrganization>> selectByUserId(Integer userId);

}
