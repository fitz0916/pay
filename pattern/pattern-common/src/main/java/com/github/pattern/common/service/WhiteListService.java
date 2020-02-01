package com.github.pattern.common.service;

import com.github.appmodel.domain.result.ModelResult;
import com.github.appmodel.vo.PageVo;
import com.github.pattern.common.domain.WhiteList;
import com.github.pattern.common.request.WhiteListRequest;

public interface WhiteListService {

	ModelResult<Integer> deleteByPrimaryKey(Integer whiteListId);

    ModelResult<Integer> insert(WhiteList record);

    ModelResult<Integer> insertSelective(WhiteList record);

    ModelResult<WhiteList> selectByPrimaryKey(Integer whiteListId);

    ModelResult<Integer> updateByPrimaryKeySelective(WhiteList record);

    ModelResult<Integer> updateByPrimaryKey(WhiteList record);

	ModelResult<PageVo> page(WhiteListRequest request);
}
