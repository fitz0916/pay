package com.github.admin.common.request;

import com.github.admin.common.domain.BaseObject;
import com.github.admin.common.domain.UserInfo;
import com.github.appmodel.page.DataPage;

public class UserRequest extends BaseRequest{
	
	
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 5599126119006893534L;
	
	
	
	private Integer userType;
	private String userName;
	private String organizationName;
	private Integer roleId;
	
	
	public Integer getUserType() {
		return userType;
	}
	public void setUserType(Integer userType) {
		this.userType = userType;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getOrganizationName() {
		return organizationName;
	}
	public void setOrganizationName(String organizationName) {
		this.organizationName = organizationName;
	}
	public Integer getRoleId() {
		return roleId;
	}
	public void setRoleId(Integer roleId) {
		this.roleId = roleId;
	}

}
