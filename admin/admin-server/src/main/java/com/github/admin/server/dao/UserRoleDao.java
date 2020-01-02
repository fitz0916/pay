package com.github.admin.server.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.github.admin.common.domain.UserRole;

@Repository
public interface UserRoleDao {

	int deleteByRoleId(@Param("roleId") Integer roleId);

	int deleteByUserId(@Param("userId") Integer userId);

	List<UserRole> selectByUserId(@Param("userId")Integer userId);


}
