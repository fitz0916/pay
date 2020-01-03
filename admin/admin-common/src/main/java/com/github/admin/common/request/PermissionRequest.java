package com.github.admin.common.request;

import com.github.admin.common.domain.BaseObject;
import com.github.admin.common.domain.PermissionInfo;
import com.github.appmodel.page.DataPage;

public class PermissionRequest extends BaseObject{
	
	private DataPage<PermissionInfo> dataPage;
	private Integer systemId;
	private Integer type;
	 
	 
	public DataPage<PermissionInfo> getDataPage() {
		return dataPage;
	}
	public void setDataPage(DataPage<PermissionInfo> dataPage) {
		this.dataPage = dataPage;
	}
	public Integer getSystemId() {
		return systemId;
	}
	public void setSystemId(Integer systemId) {
		this.systemId = systemId;
	}
	public Integer getType() {
		return type;
	}
	public void setType(Integer type) {
		this.type = type;
	}
	 
	 

}
