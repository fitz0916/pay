package com.github.trans.server.service;

import com.github.appmodel.domain.result.ModelResult;
import com.github.appmodel.page.DataPage;
import com.github.appmodel.request.PageRequest;

public abstract class BaseService {
	
	
	protected ModelResult<Integer> operation(Integer result){
		ModelResult<Integer> modelResult = new ModelResult<Integer>();
		if(result > 0) {
			modelResult.setModel(result);
		}else {
			modelResult.withError("0", "操作失败");
		}
		return modelResult;
	}

	public <T> void setDataPage(DataPage<T> dataPage,PageRequest request) {
		dataPage.setPageSize(request.getLimit());
		dataPage.setPageNo(request.getOffset()/request.getLimit()+1);
	}
}
