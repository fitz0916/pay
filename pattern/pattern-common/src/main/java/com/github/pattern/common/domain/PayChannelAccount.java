package com.github.pattern.common.domain;

import java.util.Date;
import java.util.List;

public class PayChannelAccount extends BaseObject {

	/**
	 * 渠道账户ID
	 */
	private Integer payChannelAccountId;

	/**
	 * 账户简称
	 */
	private String simpleName;

	/**
	 * 账户全称
	 */
	private String fullName;

	/**
	 * 支付渠道ID
	 */
	private Integer payChannelId;

	/**
	 * 是否锁定 0否 1是
	 */
	private Integer isLock;

	/**
	 * 商务联系人
	 */
	private String businessContacts;

	/**
	 * QQ
	 */
	private String qq;

	/**
	 * 微信
	 */
	private String wechat;

	/**
	 * 商务联系人手机号码
	 */
	private String mobile;

	/**
	 * 备注
	 */
	private String remark;

	/**
	 * 支持类型 1支付 2代付（可多选，中间用,号隔开）
	 */
	private String supportTypes;

	/**
	 * 创建时间
	 */
	private Date createTime;

	/**
	 * 支付渠道(临时字段，不存入数据库)
	 */
	private PayChannel payChannel;

	/**
	 * 主键列表(临时字段，不存入数据库）
	 */
	private List<Integer> primaryKeyList;

	public Integer getPayChannelAccountId() {
		return payChannelAccountId;
	}

	public void setPayChannelAccountId(Integer payChannelAccountId) {
		this.payChannelAccountId = payChannelAccountId;
	}

	public Integer getPayChannelId() {
		return payChannelId;
	}

	public void setPayChannelId(Integer payChannelId) {
		this.payChannelId = payChannelId;
	}

	public String getSimpleName() {
		return simpleName;
	}

	public void setSimpleName(String simpleName) {
		this.simpleName = simpleName;
	}

	public String getFullName() {
		return fullName;
	}

	public void setFullName(String fullName) {
		this.fullName = fullName;
	}


	public Integer getIsLock() {
		return isLock;
	}

	public void setIsLock(Integer isLock) {
		this.isLock = isLock;
	}

	public String getBusinessContacts() {
		return businessContacts;
	}

	public void setBusinessContacts(String businessContacts) {
		this.businessContacts = businessContacts;
	}

	public String getQq() {
		return qq;
	}

	public void setQq(String qq) {
		this.qq = qq;
	}

	public String getWechat() {
		return wechat;
	}

	public void setWechat(String wechat) {
		this.wechat = wechat;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public PayChannel getPayChannel() {
		return payChannel;
	}

	public void setPayChannel(PayChannel payChannel) {
		this.payChannel = payChannel;
	}

	public List<Integer> getPrimaryKeyList() {
		return primaryKeyList;
	}

	public void setPrimaryKeyList(List<Integer> primaryKeyList) {
		this.primaryKeyList = primaryKeyList;
	}

	public String getSupportTypes() {
		return supportTypes;
	}

	public void setSupportTypes(String supportTypes) {
		this.supportTypes = supportTypes;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
}