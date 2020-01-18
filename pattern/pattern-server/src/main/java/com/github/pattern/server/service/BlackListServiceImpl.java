package com.github.pattern.server.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.appmodel.domain.result.ModelResult;
import com.github.appmodel.page.DataPage;
import com.github.pattern.common.domain.BlackList;
import com.github.pattern.common.request.BlackListRequest;
import com.github.pattern.common.service.BlackListService;
import com.github.pattern.common.vo.PageVo;
import com.github.pattern.server.dao.BlackListDao;

@Service
public class BlackListServiceImpl extends BaseService implements BlackListService{

	@Autowired
	private BlackListDao paymentBlackListDao;
	
	@Override
	public ModelResult<Integer> deleteByPrimaryKey(Integer blackListId) {
		ModelResult<Integer> modelResult = new ModelResult<Integer>();
		if(blackListId == null || blackListId == 0) {
			modelResult.withError("0", "非法参数");
			return modelResult;
		}
		int result = paymentBlackListDao.deleteByPrimaryKey(blackListId);
		return this.operation(result);
	}

	@Override
	public ModelResult<Integer> insertSelective(BlackList record) {
		ModelResult<Integer> modelResult = new ModelResult<Integer>();
		if(record == null) {
			modelResult.withError("0", "非法参数");
			return modelResult;
		}
		Date date = new Date();
		record.setCreateTime(date);
		record.setUpdateTime(date);
		int result = paymentBlackListDao.insertSelective(record);
		return this.operation(result);
	}

	@Override
	public ModelResult<BlackList> selectByPrimaryKey(Integer blackListId) {
		ModelResult<BlackList> modelResult = new ModelResult<BlackList>();
		if(blackListId == null|| blackListId == 0) {
			modelResult.withError("0", "非法参数");
			return modelResult;
		}
		BlackList paymentBlackList = paymentBlackListDao.selectByPrimaryKey(blackListId);
		modelResult.setModel(paymentBlackList);
		return modelResult;
	}

	@Override
	public ModelResult<Integer> updateByPrimaryKeySelective(BlackList record) {
		ModelResult<Integer> modelResult = new ModelResult<Integer>();
		if(record == null) {
			modelResult.withError("0", "非法参数");
			return modelResult;
		}
		record.setUpdateTime(new Date());
		int result = paymentBlackListDao.updateByPrimaryKeySelective(record);
		return this.operation(result);
	}

	@Override
	public ModelResult<Integer> updateByPrimaryKey(BlackList record) {
		ModelResult<Integer> modelResult = new ModelResult<Integer>();
		if(record == null) {
			modelResult.withError("0", "非法参数");
			return modelResult;
		}
		record.setUpdateTime(new Date());
		int result = paymentBlackListDao.updateByPrimaryKey(record);
		return this.operation(result);
	}

	@Override
	public ModelResult<PageVo> page(BlackListRequest request) {
		ModelResult<PageVo> modelResult = new ModelResult<PageVo>();
		DataPage<BlackList> dataPage = new DataPage<BlackList>();
		PageVo pageVo = new PageVo();
		this.setDataPage(dataPage, request);
		int start = dataPage.getStartIndex();
		int offset = dataPage.getPageSize();
		long totalCount = paymentBlackListDao.pageCount();
		List<BlackList> result = paymentBlackListDao.pageList(start,offset);
        dataPage.setDataList(result);
        pageVo.setRows(result);
        pageVo.setTotal(totalCount);
        modelResult.setModel(pageVo);
        return modelResult;
	}
	
	

}
