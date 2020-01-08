package com.github.pattern.server.service;

import java.util.ArrayList;
import java.util.List;

import com.github.appmodel.page.DataPage;
import com.github.pattern.common.request.PageRequest;

public abstract class BaseService {
	
	
	protected void setDataPage(DataPage<?> dataPage,PageRequest request) {
		dataPage.setPageSize(request.getLimit());
		dataPage.setPageNo(request.getOffset()/request.getLimit()+1);
	}

	
	
	protected List<Integer> buildStatusList(){
		List<Integer> list = new ArrayList<Integer>();
		list.add(0);
		list.add(1);
		return list;
	}
}
