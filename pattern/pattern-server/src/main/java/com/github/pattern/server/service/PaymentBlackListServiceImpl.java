package com.github.pattern.server.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.appmodel.domain.result.ModelResult;
import com.github.appmodel.page.DataPage;
import com.github.pattern.common.domain.Agent;
import com.github.pattern.common.domain.PaymentBlackList;
import com.github.pattern.common.request.PaymentBlackListRequest;
import com.github.pattern.common.service.PaymentBlackListService;
import com.github.pattern.common.vo.PageVo;
import com.github.pattern.server.dao.PaymentBlackListDao;

@Service
public class PaymentBlackListServiceImpl extends BaseService implements PaymentBlackListService{

	@Autowired
	private PaymentBlackListDao paymentBlackListDao;
	
	@Override
	public ModelResult<Integer> deleteByPrimaryKey(Integer paymentBlackListId) {
		ModelResult<Integer> modelResult = new ModelResult<Integer>();
		if(paymentBlackListId == null || paymentBlackListId == 0) {
			modelResult.withError("0", "非法参数");
			return modelResult;
		}
		int result = paymentBlackListDao.deleteByPrimaryKey(paymentBlackListId);
		return this.operation(result);
	}

	@Override
	public ModelResult<Integer> insertSelective(PaymentBlackList record) {
		ModelResult<Integer> modelResult = new ModelResult<Integer>();
		if(record == null || record.getCustomerId() == null || record.getCustomerId() == 0) {
			modelResult.withError("0", "非法参数");
			return modelResult;
		}
		int result = paymentBlackListDao.insertSelective(record);
		return this.operation(result);
	}

	@Override
	public ModelResult<PaymentBlackList> selectByPrimaryKey(Integer paymentBlackListId) {
		ModelResult<PaymentBlackList> modelResult = new ModelResult<PaymentBlackList>();
		if(paymentBlackListId == null|| paymentBlackListId == 0) {
			modelResult.withError("0", "非法参数");
			return modelResult;
		}
		PaymentBlackList paymentBlackList = paymentBlackListDao.selectByPrimaryKey(paymentBlackListId);
		modelResult.setModel(paymentBlackList);
		return modelResult;
	}

	@Override
	public ModelResult<Integer> updateByPrimaryKeySelective(PaymentBlackList record) {
		ModelResult<Integer> modelResult = new ModelResult<Integer>();
		if(record == null || record.getCustomerId() == null || record.getCustomerId() == 0) {
			modelResult.withError("0", "非法参数");
			return modelResult;
		}
		int result = paymentBlackListDao.updateByPrimaryKeySelective(record);
		return this.operation(result);
	}

	@Override
	public ModelResult<Integer> updateByPrimaryKey(PaymentBlackList record) {
		ModelResult<Integer> modelResult = new ModelResult<Integer>();
		if(record == null || record.getCustomerId() == null || record.getCustomerId() == 0) {
			modelResult.withError("0", "非法参数");
			return modelResult;
		}
		int result = paymentBlackListDao.updateByPrimaryKey(record);
		return this.operation(result);
	}

	@Override
	public ModelResult<PageVo> page(PaymentBlackListRequest request) {
		ModelResult<PageVo> modelResult = new ModelResult<PageVo>();
		DataPage<PaymentBlackList> dataPage = new DataPage<PaymentBlackList>();
		PageVo pageVo = new PageVo();
		Integer customerId = request.getCustomerId();
		if(customerId == null || customerId == 0) {
			modelResult.withError("0", "非法参数");
			return modelResult;
		}
		this.setDataPage(dataPage, request);
		int start = dataPage.getStartIndex();
		int offset = dataPage.getPageSize();
		long totalCount = paymentBlackListDao.pageCount(customerId);
		List<PaymentBlackList> result = paymentBlackListDao.pageList(start,offset,customerId);
        dataPage.setDataList(result);
        pageVo.setRows(result);
        pageVo.setTotal(totalCount);
        modelResult.setModel(pageVo);
        return modelResult;
	}
	
	

}
