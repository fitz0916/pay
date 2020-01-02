package com.github.admin.server.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.github.admin.common.domain.UserOrganization;

@Repository
public interface UserOrganizationDao {

	void deleteByUserId(@Param("userId")Integer userId);

	int insertSelective(UserOrganization userOrganization);

	List<UserOrganization> selectByUserId(@Param("userId")Integer userId);

}
