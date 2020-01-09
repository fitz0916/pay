package com.github.pattern.web.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.github.appmodel.domain.result.ModelResult;
import com.github.pattern.common.domain.Shop;
import com.github.pattern.common.request.ShopRequest;
import com.github.pattern.common.service.ShopService;
import com.github.pattern.common.vo.PageVo;

@RestController
@RequestMapping("/pattern/server/shop")
public class ShopController {
	
	@Autowired
	private ShopService shopServiceImpl;
	
	
	@PostMapping("/page")
	public ModelResult<PageVo> page(@RequestBody ShopRequest request){
		return shopServiceImpl.page(request);
	}
	
	@PostMapping("/selectByAgentId/{agentId}")
	public ModelResult<List<Shop>> selectByAgentId(@PathVariable("agentId")Integer agentId){
		return shopServiceImpl.selectByAgentId(agentId);
	}
	
	@PostMapping("/deleteByPrimaryKey/{shopId}")
	public ModelResult<Integer> deleteByPrimaryKey(@PathVariable("shopId")Integer shopId){
		return shopServiceImpl.deleteByPrimaryKey(shopId);
	}

	@PostMapping("/insert")
	public ModelResult<Integer> insert(@RequestBody Shop record){
		return shopServiceImpl.insert(record);
	}

	@PostMapping("/insertSelective")
	public ModelResult<Integer> insertSelective(@RequestBody Shop record){
		return shopServiceImpl.insertSelective(record);
	}

	@PostMapping("/selectByPrimaryKey/{shopId}")
	public ModelResult<Shop> selectByPrimaryKey(@PathVariable("shopId")Integer shopId){
		return shopServiceImpl.selectByPrimaryKey(shopId);
	}

	@PostMapping("/updateByPrimaryKeySelective")
	public ModelResult<Integer> updateByPrimaryKeySelective(@RequestBody Shop record){
		return shopServiceImpl.updateByPrimaryKeySelective(record);
	}

	@PostMapping("/updateByPrimaryKey")
	public ModelResult<Integer> updateByPrimaryKey(@RequestBody Shop record){
		return shopServiceImpl.updateByPrimaryKey(record);
	}

}
