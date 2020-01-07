package com.github.pattern.common.domain;

import java.util.Date;

/**
 * 代理商/商户
 */
public class Agent extends BaseObject{
	
	private static final long serialVersionUID = -8459939368321454348L;

	private Integer agentId;
	/**代理商名称**/
	private String agentName;
	/**代理商编号**/
	private String agentNo;
	/**性质（1个体工商户 2公司/企业）**/
	private Integer type;
	/**公司注册时间**/
	private Date registryDate;
    /**营业执照号**/
	private String businessLicense;
	/**联系地址**/
    private String address;
    /**公司营业执照照片**/
    private String companyPicPath;
    /**身份证正面**/
    private String idCardFrontPath;
    /**身份证反面**/
    private String idCardBackPath;
    /**手机号码**/
    private String phone;
    /**email**/
    private String email;
    /**qq**/
    private String qq;
    /**微信**/
    private String weChat;
    /**注册时间**/
    private Date createDate;
    /**更新时间**/
    private Date updateDate;
    
	public Integer getAgentId() {
		return agentId;
	}
	public void setAgentId(Integer agentId) {
		this.agentId = agentId;
	}
	public String getAgentName() {
		return agentName;
	}
	public void setAgentName(String agentName) {
		this.agentName = agentName;
	}
	public String getAgentNo() {
		return agentNo;
	}
	public void setAgentNo(String agentNo) {
		this.agentNo = agentNo;
	}
	public Integer getType() {
		return type;
	}
	public void setType(Integer type) {
		this.type = type;
	}
	public Date getRegistryDate() {
		return registryDate;
	}
	public void setRegistryDate(Date registryDate) {
		this.registryDate = registryDate;
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
	public String getBusinessLicense() {
		return businessLicense;
	}
	public void setBusinessLicense(String businessLicense) {
		this.businessLicense = businessLicense;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getCompanyPicPath() {
		return companyPicPath;
	}
	public void setCompanyPicPath(String companyPicPath) {
		this.companyPicPath = companyPicPath;
	}
	public String getIdCardFrontPath() {
		return idCardFrontPath;
	}
	public void setIdCardFrontPath(String idCardFrontPath) {
		this.idCardFrontPath = idCardFrontPath;
	}
	public String getIdCardBackPath() {
		return idCardBackPath;
	}
	public void setIdCardBackPath(String idCardBackPath) {
		this.idCardBackPath = idCardBackPath;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getQq() {
		return qq;
	}
	public void setQq(String qq) {
		this.qq = qq;
	}
	public String getWeChat() {
		return weChat;
	}
	public void setWeChat(String weChat) {
		this.weChat = weChat;
	}


    
   
    
	
	

	
}