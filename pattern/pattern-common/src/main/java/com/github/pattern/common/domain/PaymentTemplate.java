package com.github.pattern.common.domain;

public class PaymentTemplate extends BaseObject {
	
    private Integer paymentTemplateId;

    private String templateName;

    private String templateDesc;

    private String payType;


    public Integer getPaymentTemplateId() {
		return paymentTemplateId;
	}

	public void setPaymentTemplateId(Integer paymentTemplateId) {
		this.paymentTemplateId = paymentTemplateId;
	}

	public String getTemplateName() {
        return templateName;
    }

    public void setTemplateName(String templateName) {
        this.templateName = templateName;
    }

    public String getTemplateDesc() {
        return templateDesc;
    }

    public void setTemplateDesc(String templateDesc) {
        this.templateDesc = templateDesc;
    }

    public String getPayType() {
        return payType;
    }

    public void setPayType(String payType) {
        this.payType = payType;
    }
}