package com.github.admin.common.request;

import com.github.admin.common.domain.PermissionInfo;
import com.github.appmodel.page.DataPage;

public class PermissionRequest extends BaseRequest{
	
	
	private Integer systemId;
	private Integer type;
	 
	 
	
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
