package com.github.pattern.common.service;

import com.github.appmodel.domain.result.ModelResult;
import com.github.pattern.common.domain.Shop;
import com.github.pattern.common.request.AgentRequest;
import com.github.pattern.common.vo.ResultVo;

public interface ShopService {
	
	ModelResult<Integer> deleteByPrimaryKey(Integer shopId);

    ModelResult<Integer> insert(Shop record);

    ModelResult<Integer> insertSelective(Shop record);

    ModelResult<Shop> selectByPrimaryKey(Integer shopId);

    ModelResult<Integer> updateByPrimaryKeySelective(Shop record);

    ModelResult<Integer> updateByPrimaryKey(Shop record);

	ModelResult<ResultVo> page(AgentRequest request);

}
