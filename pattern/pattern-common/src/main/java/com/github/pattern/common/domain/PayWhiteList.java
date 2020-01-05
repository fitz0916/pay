package com.github.pattern.common.domain;

import java.util.Date;

/**
 * 商户支付白名单
 * 
 */
public class PayWhiteList extends BaseObject {

	private static final long serialVersionUID = -8459939368321454348L;

	/**
	 * pay_white_list_id 主键
	 */
	private Integer payWhiteListId;
	/**
	 * agent_id 商户ID
	 */
	private Integer agentId;
	/**
	 * addr_type 地址类型:0 域名,1 ipv4,2 ipv6
	 */
	private Integer addrType;
	/**
	 * address 地址
	 */
	private String address;
	/**
	 * status 状态，0未生效，1生效
	 */
	private Integer status;
	/**
	 * remark 备注
	 */
	private String remark;
	/**
	 * create_time 创建时间
	 */
	private Date createTime;

	public Integer getPayWhiteListId() {
		return this.payWhiteListId;
	}

	public void setPayWhiteListId(Integer value) {
		this.payWhiteListId = value;
	}

	public Integer getAgentId() {
		return this.agentId;
	}

	public void setAgentId(Integer value) {
		this.agentId = value;
	}

	public Integer getAddrType() {
		return this.addrType;
	}

	public void setAddrType(Integer value) {
		this.addrType = value;
	}

	public String getAddress() {
		return this.address;
	}

	public void setAddress(String value) {
		this.address = value;
	}

	public Integer getStatus() {
		return this.status;
	}

	public void setStatus(Integer value) {
		this.status = value;
	}

	public String getRemark() {
		return this.remark;
	}

	public void setRemark(String value) {
		this.remark = value;
	}

	public Date getCreateTime() {
		return this.createTime;
	}

	public void setCreateTime(Date value) {
		this.createTime = value;
	}

}