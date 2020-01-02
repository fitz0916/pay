package com.github.admin.server.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.github.admin.common.domain.Organization;

@Repository
public interface OrganizationDao {

	public List<Organization> pageOrganizationList(@Param("start")int start, @Param("offset")int offset);
	
	public long pageOrganizationListCount();

	public int insertSelective(Organization organization);

	public Organization selectByPrimaryKey(@Param("organizationId") int organizationId);

	public int updateByPrimaryKeySelective(Organization organization);

	public int deleteByPrimaryKey(@Param("organizationId")String organizationId);

	public List<Organization> allOrganizationList();

}
