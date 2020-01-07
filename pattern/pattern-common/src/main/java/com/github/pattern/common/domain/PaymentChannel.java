package com.github.pattern.common.domain;

import java.util.Date;

/***
 * 支付渠道
 *
 */
public class PaymentChannel extends BaseObject {
	/**
	 * 支付渠道ID
	 */
	private Integer paymentChannelId;
	/**
	 * 渠道简称
	 */
	private String channelName;
	/**
	 * 对接三方支付名称
	 * 
	 **/
	private String thirdChannelName;
	
	//结算方式
	private Integer settlementType;
		
	/***
	 * 渠道状态0：停用 1：启用
	 */
	private Integer status;

	/**
	 * 支付类型
	 */
	private Integer payType;
	/**
	 * 渠道创建时间
	 */
	private Date createTime;
	/**
	 * 渠道更新时间
	 */
	private Date updateTime;
	
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

	public Integer getPaymentChannelId() {
		return paymentChannelId;
	}

	public void setPaymentChannelId(Integer paymentChannelId) {
		this.paymentChannelId = paymentChannelId;
	}

	public String getChannelName() {
		return channelName;
	}

	public void setChannelName(String channelName) {
		this.channelName = channelName;
	}

	public String getThirdChannelName() {
		return thirdChannelName;
	}

	public void setThirdChannelName(String thirdChannelName) {
		this.thirdChannelName = thirdChannelName;
	}

	public Integer getSettlementType() {
		return settlementType;
	}

	public void setSettlementType(Integer settlementType) {
		this.settlementType = settlementType;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public Integer getPayType() {
		return payType;
	}

	public void setPayType(Integer payType) {
		this.payType = payType;
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
	
	
}