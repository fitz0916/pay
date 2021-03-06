package com.github.pattern.common.service;

import com.github.appmodel.domain.result.ModelResult;
import com.github.appmodel.vo.PageVo;
import com.github.pattern.common.domain.Agent;
import com.github.pattern.common.request.AgentRequest;

public interface AgentService {
	
	ModelResult<PageVo> page(AgentRequest request);
	
	ModelResult<Integer> deleteByPrimaryKey(Integer agentId);

	ModelResult<Integer> insertSelective(Agent record);

	ModelResult<Agent> selectByPrimaryKey(Integer agentId);

    ModelResult<Integer> updateByPrimaryKeySelective(Agent record);

    ModelResult<Integer> updateByPrimaryKey(Agent record);

}
