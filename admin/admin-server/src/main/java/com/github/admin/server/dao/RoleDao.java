package com.github.admin.server.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.github.admin.common.domain.Role;

@Repository
public interface RoleDao {

	List<Role> selectRoleByUserId(@Param("userId") Integer userId);

	int deleteByPrimaryKey(@Param("roleId")Integer roleId);

	Role selectRoleByRoleName(@Param("name")String name);

	int insertSelective(Role role);

	Role selectByPrimaryKey(@Param("roleId")Integer roleId);

	int updateByPrimaryKeySelective(Role role);

	List<Role> allRolesList();

	long pageRoleListCount();

	List<Role> pageRoleList(@Param("start")int start, @Param("offset")int offset);

}
