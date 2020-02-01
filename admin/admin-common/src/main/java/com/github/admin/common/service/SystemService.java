package com.github.admin.common.service;

import java.util.List;

import com.github.admin.common.domain.System;
import com.github.admin.common.request.SystemRequest;
import com.github.appmodel.domain.result.ModelResult;
import com.github.appmodel.vo.PageVo;


public interface SystemService {

	ModelResult<PageVo> pageSystemList(SystemRequest systemRequest);

	ModelResult<Integer> insertSelective(System system);

	ModelResult<Integer> deleteByPrimaryKey(String ids);

	ModelResult<System> selectByPrimaryKey(Integer systemId);

	ModelResult<Integer> updateByPrimaryKeySelective(System system);

	ModelResult<List<System>> querySystemByStatus(Integer status);

}
