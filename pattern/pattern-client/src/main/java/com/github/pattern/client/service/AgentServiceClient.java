package com.github.pattern.client.service;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.github.appmodel.domain.result.ModelResult;
import com.github.pattern.common.domain.Agent;
import com.github.pattern.common.request.AgentRequest;
import com.github.pattern.common.vo.ResultVo;


@FeignClient(name="pattern-server")
@RequestMapping("/pattern/server/agent")
public interface AgentServiceClient {
	
	@PostMapping("/page")
	ModelResult<ResultVo> page(@RequestBody AgentRequest request);
	
	@PostMapping("/deleteByPrimaryKey/{agentId}")
	ModelResult<Integer> deleteByPrimaryKey(@PathVariable("agentId")Integer agentId);

	@PostMapping("/insertSelective")
	ModelResult<Integer> insertSelective(@RequestBody Agent record);

	@PostMapping("/selectByPrimaryKey/{agentId}")
	ModelResult<Agent> selectByPrimaryKey(@PathVariable("agentId")Integer agentId);

	@PostMapping("/updateByPrimaryKeySelective")
    ModelResult<Integer> updateByPrimaryKeySelective(@RequestBody Agent record);

	
	@PostMapping("/updateByPrimaryKey")
    ModelResult<Integer> updateByPrimaryKey(@RequestBody Agent record);

}
