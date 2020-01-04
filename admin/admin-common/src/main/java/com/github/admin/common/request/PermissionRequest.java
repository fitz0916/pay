package com.github.admin.common.request;

public class PermissionRequest extends PageRequest{
	
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -3457050356287947852L;
	private Integer systemId;
	private Integer type;
	private String name;
	 
	
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
	public String getName() {
		return name; 
	}
	public void setName(String name) {
		this.name = name;
	}
	 
	 

}
