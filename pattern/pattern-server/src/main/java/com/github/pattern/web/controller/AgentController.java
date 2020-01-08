package com.github.pattern.web.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.github.appmodel.domain.result.ModelResult;
import com.github.pattern.common.domain.Agent;
import com.github.pattern.common.request.AgentRequest;
import com.github.pattern.common.service.AgentService;
import com.github.pattern.common.vo.ResultVo;

@RestController
@RequestMapping("/pattern/server/agent")
public class AgentController {
	
	
	@Autowired
	private AgentService agentServiceImpl;
	
	@PostMapping("/page")
	ModelResult<ResultVo> page(@RequestBody AgentRequest request){
		return agentServiceImpl.page(request);
	}
	
	@PostMapping("/deleteByPrimaryKey/{agentId}")
	ModelResult<Integer> deleteByPrimaryKey(@PathVariable("agentId")Integer agentId){
		return agentServiceImpl.deleteByPrimaryKey(agentId);
	}

	@PostMapping("/insertSelective")
	ModelResult<Integer> insertSelective(@RequestBody Agent record){
		return agentServiceImpl.insertSelective(record);
	}

	@PostMapping("/selectByPrimaryKey/{agentId}")
	ModelResult<Agent> selectByPrimaryKey(@PathVariable("agentId")Integer agentId){
		return agentServiceImpl.selectByPrimaryKey(agentId);
	}

	@PostMapping("/updateByPrimaryKeySelective")
    ModelResult<Integer> updateByPrimaryKeySelective(@RequestBody Agent record){
		return agentServiceImpl.updateByPrimaryKeySelective(record);
	}

	
	@PostMapping("/updateByPrimaryKey")
    ModelResult<Integer> updateByPrimaryKey(@RequestBody Agent record){
		return agentServiceImpl.updateByPrimaryKey(record);
	}

}
