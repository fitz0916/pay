package com.github.admin.common.service;

import java.util.List;

import com.github.admin.common.domain.Organization;
import com.github.admin.common.vo.PageVo;
import com.github.appmodel.domain.result.ModelResult;
import com.github.appmodel.page.DataPage;

public interface OrganizationService {

	ModelResult<PageVo> pageOrganizationList(DataPage<Organization> dataPage);
	
	public ModelResult<Integer> insertSelective(Organization organization);

	public ModelResult<Organization> selectByPrimaryKey(Integer organizationId);

	public ModelResult<Integer> updateByPrimaryKeySelective(Organization organization);

	public ModelResult<Integer> deleteByPrimaryKey(String organizationId);

	public ModelResult<List<Organization>> allOrganizationList();
	
}
