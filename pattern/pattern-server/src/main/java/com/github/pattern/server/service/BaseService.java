package com.github.pattern.server.service;

import java.util.ArrayList;
import java.util.List;

import com.github.appmodel.domain.result.ModelResult;
import com.github.appmodel.page.DataPage;
import com.github.pattern.common.request.PageRequest;

public abstract class BaseService {
	
	protected final String INSERT_FAIL_MSG = "添加失败";
	protected final String INSERT_SUCCESS_MSG = "添加成功";
	protected final String UPDATE_FAIL_MSG = "编辑失败";
	protected final String UPDATE_SUCCESS_MSG = "编辑成功";
	protected final String DELETE_FAIL_MSG = "删除失败";
	protected final String DELETE_SUCCESS_MSG = "删除成功";
	
	
	public <T> void setDataPage(DataPage<T> dataPage,PageRequest request) {
		dataPage.setPageSize(request.getLimit());
		dataPage.setPageNo(request.getOffset()/request.getLimit()+1);
	}

	
	
	protected ModelResult<Integer> operation(Integer result){
		ModelResult<Integer> modelResult = new ModelResult<Integer>();
		if(result > 0) {
			modelResult.withError("0", "操作失败");
		}else {
			modelResult.setModel(result);
		}
		return modelResult;
	}
	
	public List<Integer> buildStatusList(){
		List<Integer> list = new ArrayList<Integer>();
		list.add(0);
		list.add(1);
		return list;
	}
}
