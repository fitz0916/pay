package com.github.pattern.common.request;

import com.github.appmodel.page.DataPage;
import com.github.pattern.common.domain.BaseObject;

public class PageRequest extends BaseObject{

	private DataPage<?> dataPage;
	private Integer offset = 0;
	private Integer limit = 10;
	private String search;
	private String order;
	
	
	public Integer getOffset() {
		return offset;
	}
	public void setOffset(Integer offset) {
		this.offset = offset;
	}
	public Integer getLimit() {
		return limit;
	}
	public void setLimit(Integer limit) {
		this.limit = limit;
	}
	public String getSearch() {
		return search;
	}
	public void setSearch(String search) {
		this.search = search;
	}
	public String getOrder() {
		return order;
	}
	public void setOrder(String order) {
		this.order = order;
	}
	public DataPage<?> getDataPage() {
		return dataPage;
	}
	public void setDataPage(DataPage<?> dataPage) {
		this.dataPage = dataPage;
	}
}
