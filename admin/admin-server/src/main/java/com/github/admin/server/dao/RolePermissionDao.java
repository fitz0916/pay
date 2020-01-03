package com.github.admin.server.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.github.admin.common.domain.RolePermission;

@Repository
public interface RolePermissionDao {

	
	public int deleteByRoleId(@Param("roleId")Integer roleId);

	public void insertSelective(RolePermission upmsRolePermission);

	public void deleteByRoleIdAndPermissionId(@Param("roleId")int roleId, @Param("permissionId")Integer permissionId);

	public List<RolePermission> selectByRoleId(@Param("roleId")int roleId);

	public int deleteByPermissionId(@Param("permissionId")Integer permissionId);

}
