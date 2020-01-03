package com.github.admin.server.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.github.admin.common.domain.UserPermission;

@Repository
public interface UserPermissionDao {

	
	int deleteByUserId(@Param("userId")Integer userId);

	int insertSelective(UserPermission userPermission);

	int deleteByTypeAndPermissionId(@Param("permissionId")int permissionId, @Param("type")Byte type);

	List<UserPermission> selectByUserIdAndType(@Param("userId")int userId, @Param("type")Integer userPermissionType);

	int deleteByPermissionId(@Param("permissionId")Integer permissionId);

}
