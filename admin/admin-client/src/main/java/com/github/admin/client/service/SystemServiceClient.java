package com.github.admin.client.service;

import java.util.List;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.github.admin.common.domain.System;
import com.github.admin.common.request.SystemRequest;
import com.github.appmodel.domain.result.ModelResult;
import com.github.appmodel.vo.PageVo;

@FeignClient(name="admin-server")
@RequestMapping("/admin/server/system")
public interface SystemServiceClient {
	
	@PostMapping("/pageSystemList")
	public ModelResult<PageVo> pageSystemList(@RequestBody SystemRequest systemRequest);

	@PostMapping("/insertSelective")
	public ModelResult<Integer> insertSelective(@RequestBody System system);

	@GetMapping("/deleteByPrimaryKey/{ids}")
	public ModelResult<Integer> deleteByPrimaryKey(@PathVariable("ids") String ids);

	@GetMapping("/selectByPrimaryKey/{systemId}")
	public ModelResult<System> selectByPrimaryKey(@PathVariable("systemId")Integer systemId);

	@PostMapping("/updateByPrimaryKeySelective")
	public ModelResult<Integer> updateByPrimaryKeySelective(@RequestBody System system);

	/***
	 * 根据状态来查询
	 * @param status
	 * @return
	 */
	@GetMapping("/querySystemByStatus/{status}")
	public ModelResult<List<System>> querySystemByStatus(@PathVariable("status")Integer status);
}
