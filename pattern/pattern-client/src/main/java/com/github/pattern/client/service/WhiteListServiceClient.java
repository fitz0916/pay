package com.github.pattern.client.service;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.github.appmodel.domain.result.ModelResult;
import com.github.pattern.common.domain.WhiteList;
import com.github.pattern.common.request.WhiteListRequest;
import com.github.pattern.common.vo.PageVo;



@FeignClient(name="pattern-server")
@RequestMapping("/pattern/server/whiteList")
public interface WhiteListServiceClient {

	@PostMapping("/page")
	ModelResult<PageVo> page(@RequestBody WhiteListRequest request);
	
	@PostMapping("/deleteByPrimaryKey/{whiteListId}")
	ModelResult<Integer> deleteByPrimaryKey(@PathVariable("whiteListId")Integer whiteListId);

	@PostMapping("/insert")
    ModelResult<Integer> insert(@RequestBody WhiteList record);

	@PostMapping("/insertSelective")
    ModelResult<Integer> insertSelective(@RequestBody WhiteList record);

	@PostMapping("/selectByPrimaryKey/{whiteListId}")
    ModelResult<WhiteList> selectByPrimaryKey(@PathVariable Integer whiteListId);

	@PostMapping("/updateByPrimaryKeySelective")
    ModelResult<Integer> updateByPrimaryKeySelective(@RequestBody WhiteList record);

	@PostMapping("/updateByPrimaryKey")
    ModelResult<Integer> updateByPrimaryKey(@RequestBody WhiteList record);
}
