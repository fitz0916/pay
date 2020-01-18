package com.github.pattern.server.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.appmodel.domain.result.ModelResult;
import com.github.appmodel.page.DataPage;
import com.github.pattern.common.domain.WhiteList;
import com.github.pattern.common.request.WhiteListRequest;
import com.github.pattern.common.service.WhiteListService;
import com.github.pattern.common.vo.PageVo;
import com.github.pattern.server.dao.WhiteListDao;

@Service
public class WhiteListServiceImpl extends BaseService implements WhiteListService{

	@Autowired
	private WhiteListDao whiteListDao;
	
	@Override
	public ModelResult<Integer> deleteByPrimaryKey(Integer whiteListId) {
		ModelResult<Integer> modelResult = new ModelResult<Integer>();
		if(whiteListId == null || whiteListId == 0) {
			modelResult.withError("0", "非法参数");
			return modelResult;
		}
		int result = whiteListDao.deleteByPrimaryKey(whiteListId);
		return this.operation(result);
	}

	@Override
	public ModelResult<Integer> insert(WhiteList record) {
		 ModelResult<Integer> modelResult = new  ModelResult<Integer>();
		 if(record == null) {
			 modelResult.withError("0", "非法参数");
			 return modelResult;
		 }
		 Date date = new Date();
		 record.setCreateTime(date);
		 record.setUpdateTime(date);
		 int result = whiteListDao.insert(record);
		 return this.operation(result);
	}

	@Override
	public ModelResult<Integer> insertSelective(WhiteList record) {
		 ModelResult<Integer> modelResult = new  ModelResult<Integer>();
		 if(record == null) {
			 modelResult.withError("0", "非法参数");
			 return modelResult;
		 }
		 Date date = new Date();
		 record.setCreateTime(date);
		 record.setUpdateTime(date);
		 int result = whiteListDao.insertSelective(record);
		 return this.operation(result);
	}

	@Override
	public ModelResult<WhiteList> selectByPrimaryKey(Integer whiteListId) {
		ModelResult<WhiteList> modelResult = new ModelResult<WhiteList>();
		 if(whiteListId == null || whiteListId == 0) {
			 modelResult.withError("0", "非法参数");
			 return modelResult;
		 }
		 WhiteList whiteList = whiteListDao.selectByPrimaryKey(whiteListId);
		 modelResult.setModel(whiteList);
		return modelResult;
	}

	@Override
	public ModelResult<Integer> updateByPrimaryKeySelective(WhiteList record) {
		ModelResult<Integer> modelResult = new ModelResult<Integer>();
		if(record == null || record.getWhiteListId() == null || record.getWhiteListId() == 0) {
			 modelResult.withError("0", "非法参数");
			 return modelResult;
		}
		record.setUpdateTime(new Date());
		int result = whiteListDao.updateByPrimaryKeySelective(record);
		return this.operation(result);
	}

	@Override
	public ModelResult<Integer> updateByPrimaryKey(WhiteList record) {
		ModelResult<Integer> modelResult = new ModelResult<Integer>();
		if(record == null || record.getWhiteListId() == null || record.getWhiteListId() == 0) {
			 modelResult.withError("0", "非法参数");
			 return modelResult;
		}
		record.setUpdateTime(new Date());
		int result = whiteListDao.updateByPrimaryKey(record);
		return this.operation(result);
	}

	@Override
	public ModelResult<PageVo> page(WhiteListRequest request) {
		ModelResult<PageVo> modelResult = new ModelResult<PageVo>();
		PageVo pageVo = new PageVo();
		DataPage<WhiteList> dataPage = new DataPage<WhiteList>();
		this.setDataPage(dataPage, request);;
		int start = dataPage.getStartIndex();
		int offset = dataPage.getPageSize();
		long totalCount = whiteListDao.pageCount();
		List<WhiteList> result = whiteListDao.pageList(start,offset);
        dataPage.setDataList(result);
        pageVo.setRows(result);
        pageVo.setTotal(totalCount);
        modelResult.setModel(pageVo);
        return modelResult;
	}

	
}
