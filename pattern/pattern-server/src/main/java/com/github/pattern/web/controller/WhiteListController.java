package com.github.pattern.web.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.github.appmodel.domain.result.ModelResult;
import com.github.appmodel.vo.PageVo;
import com.github.pattern.common.domain.WhiteList;
import com.github.pattern.common.request.WhiteListRequest;
import com.github.pattern.common.service.WhiteListService;


@RestController
@RequestMapping("/pattern/server/whiteList")
public class WhiteListController {

	@Autowired
	private WhiteListService whiteListServiceImpl;;
	
	@PostMapping("/page")
	public ModelResult<PageVo> page(@RequestBody WhiteListRequest request){
		return whiteListServiceImpl.page(request);
	}
	
	@PostMapping("/deleteByPrimaryKey/{whiteListId}")
	public ModelResult<Integer> deleteByPrimaryKey(@PathVariable("whiteListId")Integer whiteListId){
		return whiteListServiceImpl.deleteByPrimaryKey(whiteListId);
	}

	@PostMapping("/insert")
	public ModelResult<Integer> insert(@RequestBody WhiteList record){
		return whiteListServiceImpl.insert(record);
	}

	@PostMapping("/insertSelective")
	public ModelResult<Integer> insertSelective(@RequestBody WhiteList record){
		return whiteListServiceImpl.insertSelective(record);
	}

	@PostMapping("/selectByPrimaryKey/{whiteListId}")
	public ModelResult<WhiteList> selectByPrimaryKey(@PathVariable Integer whiteListId){
		return whiteListServiceImpl.selectByPrimaryKey(whiteListId);
	}

	@PostMapping("/updateByPrimaryKeySelective")
	public ModelResult<Integer> updateByPrimaryKeySelective(@RequestBody WhiteList record){
		return whiteListServiceImpl.updateByPrimaryKeySelective(record);
	}

	@PostMapping("/updateByPrimaryKey")
	public ModelResult<Integer> updateByPrimaryKey(@RequestBody WhiteList record){
		return whiteListServiceImpl.updateByPrimaryKey(record);
	}
}
