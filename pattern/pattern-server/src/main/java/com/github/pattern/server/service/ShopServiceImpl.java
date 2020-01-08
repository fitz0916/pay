package com.github.pattern.server.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.appmodel.domain.result.ModelResult;
import com.github.appmodel.page.DataPage;
import com.github.pattern.common.domain.Agent;
import com.github.pattern.common.domain.Shop;
import com.github.pattern.common.request.ShopRequest;
import com.github.pattern.common.service.ShopService;
import com.github.pattern.common.vo.PageVo;
import com.github.pattern.server.dao.ShopDao;

@Service
public class ShopServiceImpl extends BaseService implements ShopService{

	@Autowired
	private ShopDao shopDao;
	
	@Override
	public ModelResult<Integer> deleteByPrimaryKey(Integer shopId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ModelResult<Integer> insert(Shop record) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ModelResult<Integer> insertSelective(Shop record) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ModelResult<Shop> selectByPrimaryKey(Integer shopId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ModelResult<Integer> updateByPrimaryKeySelective(Shop record) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ModelResult<Integer> updateByPrimaryKey(Shop record) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ModelResult<PageVo> page(ShopRequest request) {
		ModelResult<PageVo> modelResult = new ModelResult<PageVo>();
		PageVo pageVo = new PageVo();
		DataPage<Agent> dataPage = new DataPage<Agent>();
		this.setDataPage(dataPage, request);;
		List<Integer> statusList = this.buildStatusList();
		int start = dataPage.getStartIndex();
		int offset = dataPage.getPageSize();
		Integer agentId = request.getAgentId();
		long totalCount = shopDao.pageCount(statusList,agentId);
		List<Agent> result = shopDao.pageList(start,offset,statusList,agentId);
        dataPage.setDataList(result);
        pageVo.setRows(result);
        pageVo.setTotal(totalCount);
        modelResult.setModel(pageVo);
        return modelResult;
	}
	
	

}
