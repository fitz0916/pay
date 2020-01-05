package com.github.pattern.common.domain;

/**
 * 商户支付通道实体类 
 */
public class CustomerPayChannelInfo extends BaseObject {

    /**
     * 商户支付通道ID
     */
    private Integer customerPayChannelInfoId;

    /**
     * 商户ID
     */
    private Integer customerId;
    

    /**
     * 支付类型ID
     */
    private Integer payTypeId;

    /**
     * 所属支付通道ID
     */
    private Integer payChannelInfoId;

    /**
     * 所属渠道账户ID
     */
    private Integer payChannelAccountId;

    /**
     * 优先级（从大到小）
     */
    private Integer priority;

    /**
     * 是否冻结
     */
    private Integer isFroze;

    /**
     * 备注
     */
    private String remark;

	public Integer getCustomerPayChannelInfoId() {
		return customerPayChannelInfoId;
	}

	public void setCustomerPayChannelInfoId(Integer customerPayChannelInfoId) {
		this.customerPayChannelInfoId = customerPayChannelInfoId;
	}

	public Integer getCustomerId() {
		return customerId;
	}

	public void setCustomerId(Integer customerId) {
		this.customerId = customerId;
	}

	public Integer getPayTypeId() {
		return payTypeId;
	}

	public void setPayTypeId(Integer payTypeId) {
		this.payTypeId = payTypeId;
	}

	public Integer getPayChannelInfoId() {
		return payChannelInfoId;
	}

	public void setPayChannelInfoId(Integer payChannelInfoId) {
		this.payChannelInfoId = payChannelInfoId;
	}

	public Integer getPayChannelAccountId() {
		return payChannelAccountId;
	}

	public void setPayChannelAccountId(Integer payChannelAccountId) {
		this.payChannelAccountId = payChannelAccountId;
	}

	public Integer getPriority() {
		return priority;
	}

	public void setPriority(Integer priority) {
		this.priority = priority;
	}

	public Integer getIsFroze() {
		return isFroze;
	}

	public void setIsFroze(Integer isFroze) {
		this.isFroze = isFroze;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}
    
    
    
   
}