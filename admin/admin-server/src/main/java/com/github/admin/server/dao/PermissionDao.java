package com.github.admin.server.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.github.admin.common.domain.Permission;

@Repository
public interface PermissionDao {

	List<Permission> selectPermissionByUserId(@Param("systemId")Integer systemId, @Param("userId")Integer userId);

}
