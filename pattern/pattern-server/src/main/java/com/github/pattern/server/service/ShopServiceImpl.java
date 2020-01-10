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
		ModelResult<Integer> modelResult = new ModelResult<Integer>();
		if(record == null) {
			modelResult.withError("0", "非法参数");
			return modelResult;
		}
		int result = shopDao.insertSelective(record);
		if(result > 0) {
			modelResult.setModel(result);
		}else {
			modelResult.withError("0", "添加失败");
		}
		return modelResult;
	}

	@Override
	public ModelResult<Shop> selectByPrimaryKey(Integer shopId) {
		ModelResult<Shop> modelResult = new ModelResult<Shop>();
		if(shopId == null || shopId == 0) {
			modelResult.withError("0", "非法参数");
			return modelResult;
		}
		Shop shop = shopDao.selectByPrimaryKey(shopId);
		modelResult.setModel(shop);
		return modelResult;
	}

	@Override
	public ModelResult<Integer> updateByPrimaryKeySelective(Shop record) {
		ModelResult<Integer> modelResult = new ModelResult<Integer>();
		if(record == null) {
			modelResult.withError("0", "非法参数");
			return modelResult;
		}
		int result = shopDao.insertSelective(record);
		if(result > 0) {
			modelResult.setModel(result);
		}else {
			modelResult.withError("0", "编辑失败");
		}
		return modelResult;
	}

	@Override
	public ModelResult<Integer> updateByPrimaryKey(Shop record) {
		ModelResult<Integer> modelResult = new ModelResult<Integer>();
		if(record == null) {
			modelResult.withError("0", "非法参数");
			return modelResult;
		}
		int result = shopDao.insertSelective(record);
		if(result > 0) {
			modelResult.setModel(result);
		}else {
			modelResult.withError("0", "编辑失败");
		}
		return modelResult;
	}

	@Override
	public ModelResult<PageVo> page(ShopRequest request) {
		ModelResult<PageVo> modelResult = new ModelResult<PageVo>();
		PageVo pageVo = new PageVo();
		DataPage<Shop> dataPage = new DataPage<Shop>();
		this.setDataPage(dataPage, request);;
		List<Integer> statusList = this.buildStatusList();
		int start = dataPage.getStartIndex();
		int offset = dataPage.getPageSize();
		Integer agentId = request.getAgentId();
		long totalCount = shopDao.pageCount(statusList,agentId);
		List<Shop> result = shopDao.pageList(start,offset,statusList,agentId);
        dataPage.setDataList(result);
        pageVo.setRows(result);
        pageVo.setTotal(totalCount);
        modelResult.setModel(pageVo);
        return modelResult;
	}

	@Override
	public ModelResult<List<Shop>> selectByAgentId(Integer agentId) {
		ModelResult<List<Shop>> modelResult = new ModelResult<List<Shop>>();
		if(agentId == null || agentId == 0) {
			modelResult.withError("0", "查询条件为非法参数");
			return modelResult;
		}
		List<Integer> statusList = this.buildStatusList();
		List<Shop> list = shopDao.selectByAgentId(statusList,agentId);
		modelResult.setModel(list);
		return modelResult;
	}
	

}
