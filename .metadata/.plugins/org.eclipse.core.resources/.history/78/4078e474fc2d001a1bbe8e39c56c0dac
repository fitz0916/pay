package com.github.admin.server.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.github.admin.common.domain.Permission;
import com.github.admin.common.domain.PermissionInfo;

@Repository
public interface PermissionDao {

	List<Permission> selectPermissionByUserId(@Param("systemId")Integer systemId, @Param("userId")Integer userId);
	
	public List<Permission> selectByStatusAndSystemId(@Param("status")int status, @Param("systemId")int systemId);

	public Permission selectByPrimaryKey(@Param("permissionId")int permissionId);

	public List<Permission> selectByParentId(@Param("parentId")int parentId);

	public int updateByPrimaryKeySelective(Permission permission);

	public int insertSelective(Permission permission);

	public int deleteByPrimaryKey(@Param("permissionId")Integer permissionId);

	public long pagePermissionInfoListCount();

	public List<PermissionInfo> pagePermissionInfoList(int start, int offset);

}
