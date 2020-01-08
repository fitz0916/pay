package com.github.pattern.server.service;

import org.springframework.stereotype.Service;

import com.github.appmodel.domain.result.ModelResult;
import com.github.pattern.common.domain.Shop;
import com.github.pattern.common.request.AgentRequest;
import com.github.pattern.common.service.ShopService;
import com.github.pattern.common.vo.ResultVo;

@Service
public class ShopServiceImpl implements ShopService{

	@Override
	public ModelResult<Integer> deleteByPrimaryKey(Integer shopId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ModelResult<Integer> insert(Shop record) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ModelResult<Integer> insertSelective(Shop record) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ModelResult<Shop> selectByPrimaryKey(Integer shopId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ModelResult<Integer> updateByPrimaryKeySelective(Shop record) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ModelResult<Integer> updateByPrimaryKey(Shop record) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ModelResult<ResultVo> page(AgentRequest request) {
		// TODO Auto-generated method stub
		return null;
	}
	
	

}
