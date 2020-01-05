package com.github.pattern.common.domain;

import java.util.Date;

public class Customer extends BaseObject{

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
    /**创建日期**/
    private Date createDate;
    /**更新日期**/
    private Date updateDate;
    
    /** 支付状态（0启用 1禁用）*/
	private Integer payStatus;

	/** 代付状态（0启用 1禁用）*/
	private Integer payoutStatus;

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
    
}
