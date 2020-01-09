package com.github.pattern.common.service;

import java.util.List;

import com.github.appmodel.domain.result.ModelResult;
import com.github.pattern.common.domain.Shop;
import com.github.pattern.common.request.ShopRequest;
import com.github.pattern.common.vo.PageVo;

public interface ShopService {
	
	ModelResult<Integer> deleteByPrimaryKey(Integer shopId);

    ModelResult<Integer> insert(Shop record);

    ModelResult<Integer> insertSelective(Shop record);

    ModelResult<Shop> selectByPrimaryKey(Integer shopId);

    ModelResult<Integer> updateByPrimaryKeySelective(Shop record);

    ModelResult<Integer> updateByPrimaryKey(Shop record);

	ModelResult<PageVo> page(ShopRequest request);

	ModelResult<List<Shop>> selectByAgentId(Integer agentId);

}
