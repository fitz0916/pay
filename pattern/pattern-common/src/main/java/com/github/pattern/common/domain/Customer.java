package com.github.pattern.common.domain;

import java.util.Date;

public class Customer extends BaseObject{

	/**
	 * 
	 */
	private static final long serialVersionUID = -4386326625439993216L;
	
	/**商户ID**/
	private Integer customerId;
	/**代理商ID**/
	private Integer agentId;
	/**门店ID**/
	private Integer shopId;
	/**商户名称**/
	private String customerName;
	/**商户号**/
	private String customerNo;
	/**带结算金额**/
	private Long settlement;
	/**冻结总额，待解冻总额**/
	private Long frozenAmount;
	/**可用余额（此金额可提现）**/
	private Long amount;
	/**支付|提现密码（很重要，商户申请提现时需用到此密码）**/
    private String cipher;
    /** 支付状态（0启用 1禁用 2删除）*/
	private Integer status;
	/** 代付方式（0自动代付 1人工代付）*/
	private Integer payoutWay;
	/**
	 * 已解冻总额
	 */
	private Long unfreezeAmount;
	/**
	 * 冻结记录的总额
	 */
	private Long frozenAmountSum;
	 /**创建日期**/
    private Date createDate;
    /**更新日期**/
    private Date updateDate;
    //是否设置渠道0：没有1：设置
    private Integer payChannelStatus;
    //渠道数量
    private Long payChannelNum;
    
	public Integer getCustomerId() {
		return customerId;
	}
	public void setCustomerId(Integer customerId) {
		this.customerId = customerId;
	}
	public Integer getAgentId() {
		return agentId;
	}
	public void setAgentId(Integer agentId) {
		this.agentId = agentId;
	}
	
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public Integer getShopId() {
		return shopId;
	}
	public void setShopId(Integer shopId) {
		this.shopId = shopId;
	}
	public String getCustomerName() {
		return customerName;
	}
	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}
	public String getCustomerNo() {
		return customerNo;
	}
	public void setCustomerNo(String customerNo) {
		this.customerNo = customerNo;
	}
	public Long getSettlement() {
		return settlement;
	}
	public void setSettlement(Long settlement) {
		this.settlement = settlement;
	}
	public Long getFrozenAmount() {
		return frozenAmount;
	}
	public void setFrozenAmount(Long frozenAmount) {
		this.frozenAmount = frozenAmount;
	}
	public Long getAmount() {
		return amount;
	}
	public void setAmount(Long amount) {
		this.amount = amount;
	}
	public String getCipher() {
		return cipher;
	}
	public void setCipher(String cipher) {
		this.cipher = cipher;
	}
	
	public Integer getPayoutWay() {
		return payoutWay;
	}
	public void setPayoutWay(Integer payoutWay) {
		this.payoutWay = payoutWay;
	}
	public Long getUnfreezeAmount() {
		return unfreezeAmount;
	}
	public void setUnfreezeAmount(Long unfreezeAmount) {
		this.unfreezeAmount = unfreezeAmount;
	}
	public Long getFrozenAmountSum() {
		return frozenAmountSum;
	}
	public void setFrozenAmountSum(Long frozenAmountSum) {
		this.frozenAmountSum = frozenAmountSum;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	public Date getUpdateDate() {
		return updateDate;
	}
	public void setUpdateDate(Date updateDate) {
		this.updateDate = updateDate;
	}
	public Integer getPayChannelStatus() {
		return payChannelStatus;
	}
	public void setPayChannelStatus(Integer payChannelStatus) {
		this.payChannelStatus = payChannelStatus;
	}
	public Long getPayChannelNum() {
		return payChannelNum;
	}
	public void setPayChannelNum(Long payChannelNum) {
		this.payChannelNum = payChannelNum;
	}
    
    
}
