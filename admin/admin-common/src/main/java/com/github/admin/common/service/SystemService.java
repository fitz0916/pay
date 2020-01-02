package com.github.admin.common.service;

import com.github.admin.common.domain.System;
import com.github.admin.common.vo.PageVo;
import com.github.appmodel.domain.result.ModelResult;
import com.github.appmodel.page.DataPage;


public interface SystemService {

	ModelResult<PageVo> pageSystemList(DataPage<System> dataPage);

	ModelResult<Integer> insertSelective(System system);

	ModelResult<Integer> deleteByPrimaryKey(String ids);

	ModelResult<System> selectByPrimaryKey(Integer systemId);

	ModelResult<Integer> updateByPrimaryKeySelective(System system);

}
