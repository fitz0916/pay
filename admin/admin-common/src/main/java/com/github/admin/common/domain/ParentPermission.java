package com.github.admin.common.domain;


public class ParentPermission extends BaseObject {

    private Integer parentId;

    private String parentPermission;

    public Integer getParentId() {
        return parentId;
    }

    public void setParentId(Integer parentId) {
        this.parentId = parentId;
    }

    public String getParentPermission() {
        return parentPermission;
    }

    public void setParentPermission(String parentPermission) {
        this.parentPermission = parentPermission;
    }
}
