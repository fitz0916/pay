package com.github.admin.common.domain;


public class PermissionInfo extends Permission {

    private String parentName;

    private String systemTitle;

    public String getParentName() {
        return parentName;
    }

    public void setParentName(String parentName) {
        this.parentName = parentName;
    }

    public String getSystemTitle() {
        return systemTitle;
    }

    public void setSystemTitle(String systemTitle) {
        this.systemTitle = systemTitle;
    }
}
