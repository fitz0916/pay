package com.github.pattern.client.service;

import java.util.List;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.github.appmodel.domain.result.ModelResult;
import com.github.pattern.common.domain.Shop;
import com.github.pattern.common.request.ShopRequest;
import com.github.pattern.common.vo.PageVo;


@FeignClient(name="pattern-server")
@RequestMapping("/pattern/server/shop")
public interface ShopServiceClient {
	
	@PostMapping("/page")
	ModelResult<PageVo> page(@RequestBody ShopRequest request);
	
	@PostMapping("/selectByAgentId/{agentId}")
	public ModelResult<List<Shop>> selectByAgentId(@PathVariable("agentId")Integer agentId);
	
	@PostMapping("/deleteByPrimaryKey/{shopId}")
	ModelResult<Integer> deleteByPrimaryKey(@PathVariable("shopId")Integer shopId);

	@PostMapping("/insert")
    ModelResult<Integer> insert(@RequestBody Shop record);

	@PostMapping("/insertSelective")
    ModelResult<Integer> insertSelective(@RequestBody Shop record);

	@PostMapping("/selectByPrimaryKey/{shopId}")
    ModelResult<Shop> selectByPrimaryKey(@PathVariable("shopId")Integer shopId);

	@PostMapping("/updateByPrimaryKeySelective")
    ModelResult<Integer> updateByPrimaryKeySelective(@RequestBody Shop record);

	@PostMapping("/updateByPrimaryKey")
    ModelResult<Integer> updateByPrimaryKey(@RequestBody Shop record);

}
