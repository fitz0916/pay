package com.github.pattern.common.domain;

import java.util.Date;

public class BlackList extends BaseObject{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -3870567893757187910L;

	private Integer blackListId;
	/**
	 * 请求IP
	 */
	private String ip;
	/**
	 * status 状态，0：禁用，1：启用 2：删除
	 */
	private Integer status;
	/**
	 * create_time 创建时间
	 */
	private Date createTime;
	/***
	 * 更新时间
	 */
	private Date updateTime;
	/**
	 * remark 备注
	 */
	private String remark;
	public Integer getBlackListId() {
		return blackListId;
	}
	public void setBlackListId(Integer blackListId) {
		this.blackListId = blackListId;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	public Date getUpdateTime() {
		return updateTime;
	}
	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	
	
	

}
