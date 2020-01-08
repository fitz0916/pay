package com.github.pattern.server.service;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.appmodel.domain.result.ModelResult;
import com.github.pattern.common.domain.Agent;
import com.github.pattern.common.request.AgentRequest;
import com.github.pattern.common.service.AgentService;
import com.github.pattern.common.vo.ResultVo;
import com.github.pattern.server.dao.AgentDao;


@Service
public class AgentServiceImpl implements AgentService{

	@Autowired
	private AgentDao agentDao;
	
	
	@Override
	public ModelResult<ResultVo> page(AgentRequest request) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ModelResult<Integer> deleteByPrimaryKey(Integer agentId) {
		ModelResult<Integer> modelResult = new ModelResult<Integer>();
		if(agentId == null || agentId == 0) {
			modelResult.withError("0", "输入非法参数");
			return modelResult;
		}
		Agent agent = agentDao.selectByPrimaryKey(agentId);
		int result = 0;
		if(agent != null) {
			agent.setStatus(3);
			result = agentDao.updateByPrimaryKeySelective(agent);
		}
		if(result > 0) {
			modelResult.setModel(result);
		} else {
			modelResult.withError("0", "删除失败");
			return modelResult;
		}
		return modelResult;
	}

	@Override
	public ModelResult<Integer> insertSelective(Agent record) {
		if(record == null || record.getAgentName())
		Date date = new Date();
		record.setCreateDate(date);
		record.setUpdateDate(date);
		int result = 
		return null;
	}

	@Override
	public ModelResult<Agent> selectByPrimaryKey(Integer agentId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ModelResult<Integer> updateByPrimaryKeySelective(Agent record) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ModelResult<Integer> updateByPrimaryKey(Agent record) {
		// TODO Auto-generated method stub
		return null;
	}
	
	

}
