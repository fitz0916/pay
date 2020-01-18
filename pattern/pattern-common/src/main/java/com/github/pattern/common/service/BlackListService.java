package com.github.pattern.common.service;

import com.github.appmodel.domain.result.ModelResult;
import com.github.pattern.common.domain.BlackList;
import com.github.pattern.common.request.BlackListRequest;
import com.github.pattern.common.vo.PageVo;

public interface BlackListService {
	
	ModelResult<Integer> deleteByPrimaryKey(Integer paymentBlackListId);

    ModelResult<Integer> insertSelective(BlackList record);

    ModelResult<BlackList> selectByPrimaryKey(Integer paymentBlackListId);

    ModelResult<Integer> updateByPrimaryKeySelective(BlackList record);

    ModelResult<Integer> updateByPrimaryKey(BlackList record);

	ModelResult<PageVo> page(BlackListRequest request);

}
