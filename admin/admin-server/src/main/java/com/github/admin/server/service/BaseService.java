package com.github.admin.server.service;

import com.github.appmodel.page.DataPage;
import com.github.appmodel.request.PageRequest;

public abstract class BaseService {

	
	
	public void setDataPage(DataPage<?> dataPage,PageRequest request) {
		dataPage.setPageSize(request.getLimit());
		dataPage.setPageNo(request.getOffset()/request.getLimit()+1);
	}
	
}
