package com.github.admin.web.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.github.admin.common.domain.System;
import com.github.admin.common.service.SystemService;
import com.github.admin.common.vo.PageVo;
import com.github.appmodel.domain.result.ModelResult;
import com.github.appmodel.page.DataPage;


@RestController
@RequestMapping("/admin/server/system")
public class SystemController {

	@Autowired
	private SystemService systemServiceImpl;
	
	
	@PostMapping("/pageSystemList")
	public ModelResult<PageVo> pageSystemList(@RequestBody DataPage<System> dataPage){
		return systemServiceImpl.pageSystemList(dataPage);
	}
	
	@PostMapping("/insertSelective")
	public ModelResult<Integer> insertSelective(@RequestBody System system){
		return systemServiceImpl.insertSelective(system);
	}
	
	@GetMapping("/deleteByPrimaryKey/{ids}")
	public ModelResult<Integer> deleteByPrimaryKey(@PathVariable("ids") String ids){
		return systemServiceImpl.deleteByPrimaryKey(ids);
	}

	@GetMapping("/selectByPrimaryKey/{systemId}")
	public ModelResult<System> selectByPrimaryKey(@PathVariable("systemId")Integer systemId){
		return systemServiceImpl.selectByPrimaryKey(systemId);
	}

	@PostMapping("/updateByPrimaryKeySelective")
	public ModelResult<Integer> updateByPrimaryKeySelective(@RequestBody System system){
		return systemServiceImpl.updateByPrimaryKeySelective(system);
	}
	
	@GetMapping("/querySystemByStatus/{status}")
	public ModelResult<List<System>> querySystemByStatus(@PathVariable("status")Integer status){
		return systemServiceImpl.querySystemByStatus(status);
	}
}
