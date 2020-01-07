package com.github.pattern.common.service;

import com.github.appmodel.domain.result.ModelResult;
import com.github.pattern.common.domain.Shop;

public interface ShopService {
	
	ModelResult<Integer> deleteByPrimaryKey(Integer shopId);

    ModelResult<Integer> insert(Shop record);

    ModelResult<Integer> insertSelective(Shop record);

    ModelResult<Shop> selectByPrimaryKey(Integer shopId);

    ModelResult<Integer> updateByPrimaryKeySelective(Shop record);

    ModelResult<Integer> updateByPrimaryKey(Shop record);

}
