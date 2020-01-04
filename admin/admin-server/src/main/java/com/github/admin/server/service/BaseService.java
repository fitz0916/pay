package com.github.admin.server.service;

import com.github.admin.common.request.PageRequest;
import com.github.appmodel.page.DataPage;

public abstract class BaseService {

	
	
	public void setDataPage(DataPage<?> dataPage,PageRequest request) {
		dataPage.setPageSize(request.getLimit());
		dataPage.setPageNo(request.getOffset()/request.getLimit()+1);
	}
	
}
