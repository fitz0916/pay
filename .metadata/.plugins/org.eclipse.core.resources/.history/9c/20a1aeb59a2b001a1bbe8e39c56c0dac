package com.github.admin.server.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.github.admin.common.domain.Role;

@Repository
public interface RoleDao {

	List<Role> selectRoleByUserId(@Param("userId") Integer userId);

}
