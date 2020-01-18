package com.github.pattern.client.service;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.github.appmodel.domain.result.ModelResult;
import com.github.pattern.common.domain.BlackList;
import com.github.pattern.common.request.BlackListRequest;
import com.github.pattern.common.vo.PageVo;

@FeignClient(name="pattern-server")
@RequestMapping("/pattern/server/blackList")
public interface BlackListServiceClient {
	
	@PostMapping("/page")
	ModelResult<PageVo> page(@RequestBody BlackListRequest request);
	
	@PostMapping("/deleteByPrimaryKey/{blackListId}")
	ModelResult<Integer> deleteByPrimaryKey(@PathVariable("blackListId")Integer blackListId);

	@PostMapping("/insertSelective")
	ModelResult<Integer> insertSelective(@RequestBody BlackList record);

	@PostMapping("/selectByPrimaryKey/{blackListId}")
	ModelResult<BlackList> selectByPrimaryKey(@PathVariable("blackListId")Integer blackListId);
	
	@PostMapping("/updateByPrimaryKeySelective")
    ModelResult<Integer> updateByPrimaryKeySelective(@RequestBody BlackList record);

	@PostMapping("/updateByPrimaryKey")
    ModelResult<Integer> updateByPrimaryKey(@RequestBody BlackList record);

}
