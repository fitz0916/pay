package com.github.pattern.server.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.appmodel.domain.result.ModelResult;
import com.github.appmodel.page.DataPage;
import com.github.pattern.common.domain.PaymentChannel;
import com.github.pattern.common.domain.Shop;
import com.github.pattern.common.request.PaymentChannelRequest;
import com.github.pattern.common.service.PaymentChannelService;
import com.github.pattern.common.vo.PageVo;
import com.github.pattern.server.dao.PaymentChannelDao;



@Service
public class PaymentChannelServiceImpl extends BaseService implements PaymentChannelService{

	@Autowired
	private PaymentChannelDao paymentChannelDao;
	
	@Override
	public ModelResult<Integer> deleteByPrimaryKey(Integer payChannelId) {
		ModelResult<Integer> modelResult = new ModelResult<Integer>();
		if(payChannelId == null || payChannelId == 0) {
			modelResult.withError("0", "参数非法");
			return modelResult;
		}
		int result = paymentChannelDao.deleteByPrimaryKey(payChannelId);
		return this.operation(result);
		
	}

	@Override
	public ModelResult<Integer> insertSelective(PaymentChannel record) {
		ModelResult<Integer> modelResult = new ModelResult<Integer>();
		if(record == null) {
			modelResult.withError("0", "参数非法");
			return modelResult;
		}
		Integer result = paymentChannelDao.insertSelective(record);
		return this.operation(result);
	}

	@Override
	public ModelResult<PaymentChannel> selectByPrimaryKey(Integer payChannelId) {
		ModelResult<PaymentChannel> modelResult = new ModelResult<PaymentChannel>();
		if(payChannelId == null || payChannelId == 0) {
			modelResult.withError("0", "参数非法");
			return modelResult;
		}
		PaymentChannel paymentChannel = paymentChannelDao.selectByPrimaryKey(payChannelId);
		modelResult.setModel(paymentChannel);
		return modelResult;
	}

	@Override
	public ModelResult<Integer> updateByPrimaryKeySelective(PaymentChannel record) {
		ModelResult<Integer> modelResult = new ModelResult<Integer>();
		if(record == null || record.getPaymentChannelId() == null || record.getPaymentChannelId() == 0) {
			modelResult.withError("0", "参数非法");
			return modelResult;
		}
		int result = paymentChannelDao.updateByPrimaryKeySelective(record);
		return this.operation(result);
	}

	@Override
	public ModelResult<Integer> updateByPrimaryKey(PaymentChannel record) {
		ModelResult<Integer> modelResult = new ModelResult<Integer>();
		if(record == null || record.getPaymentChannelId() == null || record.getPaymentChannelId() == 0) {
			modelResult.withError("0", "参数非法");
			return modelResult;
		}
		int result = paymentChannelDao.updateByPrimaryKey(record);
		return this.operation(result);
	}

	@Override
	public ModelResult<PageVo> page(PaymentChannelRequest request) {
		ModelResult<PageVo> modelResult = new ModelResult<PageVo>();
		PageVo pageVo = new PageVo();
		DataPage<PaymentChannel> dataPage = new DataPage<PaymentChannel>();
		this.setDataPage(dataPage, request);;
		int start = dataPage.getStartIndex();
		int offset = dataPage.getPageSize();
		long totalCount = paymentChannelDao.pageCount();
		List<PaymentChannel> result = paymentChannelDao.pageList(start,offset);
        dataPage.setDataList(result);
        pageVo.setRows(result);
        pageVo.setTotal(totalCount);
        modelResult.setModel(pageVo);
        return modelResult;
	}

		
}
