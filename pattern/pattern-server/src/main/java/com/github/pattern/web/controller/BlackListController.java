package com.github.pattern.web.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.github.appmodel.domain.result.ModelResult;
import com.github.appmodel.vo.PageVo;
import com.github.pattern.common.domain.BlackList;
import com.github.pattern.common.request.BlackListRequest;
import com.github.pattern.common.service.BlackListService;

@RestController
@RequestMapping("/pattern/server/blackList")
public class BlackListController {
	
	
	@Autowired
	private BlackListService blackListServiceImpl;
	
	@PostMapping("/page")
	public ModelResult<PageVo> page(@RequestBody BlackListRequest request){
		return blackListServiceImpl.page(request);
	}
	
	@PostMapping("/deleteByPrimaryKey/{blackListId}")
	public ModelResult<Integer> deleteByPrimaryKey(@PathVariable("blackListId")Integer blackListId){
		return blackListServiceImpl.deleteByPrimaryKey(blackListId);
	}

	@PostMapping("/insertSelective")
	public ModelResult<Integer> insertSelective(@RequestBody BlackList record){
		return blackListServiceImpl.insertSelective(record);
	}

	@PostMapping("/selectByPrimaryKey/{blackListId}")
	public ModelResult<BlackList> selectByPrimaryKey(@PathVariable("blackListId")Integer blackListId){
		return blackListServiceImpl.selectByPrimaryKey(blackListId);
	}
	
	@PostMapping("/updateByPrimaryKeySelective")
	public ModelResult<Integer> updateByPrimaryKeySelective(@RequestBody BlackList record){
		return blackListServiceImpl.updateByPrimaryKeySelective(record);
	}

	@PostMapping("/updateByPrimaryKey")
	public ModelResult<Integer> updateByPrimaryKey(@RequestBody BlackList record){
		return blackListServiceImpl.updateByPrimaryKey(record);
	}

}
