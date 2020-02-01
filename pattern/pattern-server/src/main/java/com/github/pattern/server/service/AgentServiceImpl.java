package com.github.pattern.server.service;

import java.util.Date;
import java.util.List;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.appmodel.domain.result.ModelResult;
import com.github.appmodel.page.DataPage;
import com.github.appmodel.vo.PageVo;
import com.github.pattern.common.constants.PatternConstants;
import com.github.pattern.common.domain.Agent;
import com.github.pattern.common.domain.Shop;
import com.github.pattern.common.request.AgentRequest;
import com.github.pattern.common.service.AgentService;
import com.github.pattern.common.utils.UUIDGenerator;
import com.github.pattern.server.dao.AgentDao;
import com.github.pattern.server.dao.ShopDao;


@Service
public class AgentServiceImpl extends BaseService implements AgentService{

	@Autowired
	private AgentDao agentDao;
	
	@Autowired
	private ShopDao shopDao;
	
	@Override
	public ModelResult<PageVo> page(AgentRequest request) {
		ModelResult<PageVo> modelResult = new ModelResult<PageVo>();
		PageVo pageVo = new PageVo();
		DataPage<Agent> dataPage = new DataPage<Agent>();
		this.setDataPage(dataPage, request);;
		List<Integer> statusList = this.buildStatusList();
		int start = dataPage.getStartIndex();
		int offset = dataPage.getPageSize();
		long totalCount = agentDao.pageCount(statusList);
		List<Agent> result = agentDao.pageList(start,offset,statusList);
        dataPage.setDataList(result);
        pageVo.setRows(result);
        pageVo.setTotal(totalCount);
        modelResult.setModel(pageVo);
        return modelResult;
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
			//判断商户是否存在，如果存在不允许删除
			List<Shop> list = shopDao.selectByAgentId(this.buildStatusList(),agentId);
			if(CollectionUtils.isEmpty(list)) {
				agent.setStatus(3);
				agent.setUpdateDate(new Date());
				result = agentDao.updateByPrimaryKeySelective(agent);
			}
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
		ModelResult<Integer> modelResult = new ModelResult<Integer>();
		if(record == null || StringUtils.isBlank(record.getAgentName())) {
			modelResult.withError("0","添加失败");
			return modelResult;
		}
		String agentNo = PatternConstants.AGENT_NO_PREFIX + UUIDGenerator.getRandomNumber(6);
		record.setAgentNo(agentNo);
		Date date = new Date();
		record.setCreateDate(date);
		record.setUpdateDate(date);
		record.setRegistryDate(date);
		String agentName = record.getAgentName();
		Agent agent = agentDao.selectByAgentName(agentName);
		if(agent != null) {
			modelResult.withError("0","代理商名称已存在！");
			return modelResult;
		}
		int result = agentDao.insertSelective(record);
		if(result > 0) {
			modelResult.setModel(result);
		}else {
			modelResult.withError("0","添加失败");
		}
		return modelResult;
	}
	
	
	

	@Override
	public ModelResult<Agent> selectByPrimaryKey(Integer agentId) {
		ModelResult<Agent> modelResult = new ModelResult<Agent>();
		if(agentId == null || agentId == 0) {
			modelResult.withError("0","查询失败");
			return modelResult;
		}
		Agent agent = agentDao.selectByPrimaryKey(agentId);
		modelResult.setModel(agent);
		return modelResult;
	}

	@Override
	public ModelResult<Integer> updateByPrimaryKeySelective(Agent record) {
		ModelResult<Integer> modelResult = new ModelResult<Integer>();
		if(record == null || record.getAgentId() == null) {
			modelResult.withError("0","编辑失败");
			return modelResult;
		}
		String agentName = record.getAgentName();
		Agent agent = agentDao.selectByAgentName(agentName);
		if(agent != null ) {
			String agentId = String.valueOf(agent.getAgentId());
			String updateAgentId = String.valueOf(record.getAgentId());
			if(!agentId.equals(updateAgentId)) {
				modelResult.withError("0","代理商名称已存在！");
				return modelResult;
			}
		}
		int result = agentDao.updateByPrimaryKeySelective(record);
		if(result > 0) {
			modelResult.setModel(result);
		}else {
			modelResult.withError("0","编辑失败");
		}
		return modelResult;
	}

	@Override
	public ModelResult<Integer> updateByPrimaryKey(Agent record) {
		ModelResult<Integer> modelResult = new ModelResult<Integer>();
		if(record == null || record.getAgentId() == null) {
			modelResult.withError("0","编辑失败");
			return modelResult;
		}
		String agentName = record.getAgentName();
		Agent agent = agentDao.selectByAgentName(agentName);
		if(agent != null ) {
			String agentId = String.valueOf(agent.getAgentId());
			String updateAgentId = String.valueOf(record.getAgentId());
			if(!agentId.equals(updateAgentId)) {
				modelResult.withError("0","代理商名称已存在！");
				return modelResult;
			}
		}
		int result = agentDao.updateByPrimaryKey(record);
		if(result > 0) {
			modelResult.setModel(result);
		}else {
			modelResult.withError("0","编辑失败");
		}
		return modelResult;
	}
	
	

}
