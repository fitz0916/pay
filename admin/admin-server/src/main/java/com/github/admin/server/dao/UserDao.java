package com.github.admin.server.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.github.admin.common.domain.User;
import com.github.admin.common.domain.UserInfo;

@Repository
public interface UserDao {

	public User selectUserByUserName(@Param("userName")String userName);

	public User selectByPrimaryKey(@Param("userId")Integer userId);

	public long pageUserInfoListCount(@Param("userName")String userName, @Param("organizationName")String organizationName, @Param("roleId")Integer roleId);

	public List<UserInfo> pageUserInfoList(@Param("userName")String userName, @Param("organizationName")String organizationName, @Param("roleId")Integer roleId,@Param("start")int start, @Param("offset")int offset);

	public int insertSelective(User user);

	public int updateByPrimaryKeySelective(User user);

	public int deleteByPrimaryKey(@Param("userId")Integer userId);

}
