package com.github.pattern.server.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.appmodel.domain.result.ModelResult;
import com.github.appmodel.page.DataPage;
import com.github.pattern.common.domain.PaymentChannel;
import com.github.pattern.common.domain.PaymentTemplate;
import com.github.pattern.common.request.PaymentChannelRequest;
import com.github.pattern.common.service.PaymentChannelService;
import com.github.pattern.common.vo.PageVo;
import com.github.pattern.server.dao.PaymentChannelDao;
import com.github.pattern.server.dao.PaymentTemplateDao;



@Service
public class PaymentChannelServiceImpl extends BaseService implements PaymentChannelService{

	@Autowired
	private PaymentChannelDao paymentChannelDao;
	
	@Autowired
	private PaymentTemplateDao paymentTemplateDao;
	
	@Override
	public ModelResult<Integer> deleteByPrimaryKey(Integer paymentChannelId) {
		ModelResult<Integer> modelResult = new ModelResult<Integer>();
		if(paymentChannelId == null || paymentChannelId == 0) {
			modelResult.withError("0", "参数非法");
			return modelResult;
		}
		int result = paymentChannelDao.deleteByPrimaryKey(paymentChannelId);
		return this.operation(result);
		
	}

	@Override
	public ModelResult<Integer> insertSelective(PaymentChannel record) {
		ModelResult<Integer> modelResult = new ModelResult<Integer>();
		if(record == null) {
			modelResult.withError("0", "参数非法");
			return modelResult;
		}
		Date date = new Date();
		record.setCreateTime(date);
		record.setUpdateTime(date);
		String channelName = record.getChannelName();
		String payType = record.getPayType();
		Integer paymentTemplateId = record.getPaymentTemplateId();
		PaymentChannel paymentChannel = paymentChannelDao.selectByChannelName(channelName);
		if(paymentChannel != null) {
			modelResult.withError("0", "改渠道名称已存在");
			return modelResult;
		}
		paymentChannel = paymentChannelDao.selectByPaymentTemplateIdAndPayType(paymentTemplateId, payType);
		if(paymentChannel != null) {
			modelResult.withError("0", "改渠道对应支付类型和渠道模板已存在");
			return modelResult;
		}
		Integer result = paymentChannelDao.insertSelective(record);
		return this.operation(result);
	}

	@Override
	public ModelResult<PaymentChannel> selectByPrimaryKey(Integer paymentChannelId) {
		ModelResult<PaymentChannel> modelResult = new ModelResult<PaymentChannel>();
		if(paymentChannelId == null || paymentChannelId == 0) {
			modelResult.withError("0", "参数非法");
			return modelResult;
		}
		PaymentChannel paymentChannel = paymentChannelDao.selectByPrimaryKey(paymentChannelId);
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
		record.setUpdateTime(new Date());
		String channelName = record.getChannelName();
		String payType = record.getPayType();
		Integer paymentTemplateId = record.getPaymentTemplateId();
		PaymentChannel paymentChannel = paymentChannelDao.selectByChannelName(channelName);
		if(paymentChannel != null) {
			String paymentChannelId = String.valueOf(paymentChannel.getPaymentChannelId());
			String recordPaymentChannelId = String.valueOf(record.getPaymentChannelId());
			if(!paymentChannelId.equals(recordPaymentChannelId)) {
				modelResult.withError("0", "改渠道名称已存在");
				return modelResult;
			}
		}
		paymentChannel = paymentChannelDao.selectByPaymentTemplateIdAndPayType(paymentTemplateId, payType);
		if(paymentChannel != null) {
			String paymentChannelId = String.valueOf(paymentChannel.getPaymentChannelId());
			String recordPaymentChannelId = String.valueOf(record.getPaymentChannelId());
			if(!paymentChannelId.equals(recordPaymentChannelId)) {
				modelResult.withError("0", "改渠道对应支付类型和渠道模板已存在");
				return modelResult;
			}
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
		record.setUpdateTime(new Date());
		String channelName = record.getChannelName();
		String payType = record.getPayType();
		Integer paymentTemplateId = record.getPaymentTemplateId();
		PaymentChannel paymentChannel = paymentChannelDao.selectByChannelName(channelName);
		if(paymentChannel != null) {
			String paymentChannelId = String.valueOf(paymentChannel.getPaymentChannelId());
			String recordPaymentChannelId = String.valueOf(record.getPaymentChannelId());
			if(!paymentChannelId.equals(recordPaymentChannelId)) {
				modelResult.withError("0", "改渠道名称已存在");
				return modelResult;
			}
		}
		paymentChannel = paymentChannelDao.selectByPaymentTemplateIdAndPayType(paymentTemplateId, payType);
		if(paymentChannel != null) {
			String paymentChannelId = String.valueOf(paymentChannel.getPaymentChannelId());
			String recordPaymentChannelId = String.valueOf(record.getPaymentChannelId());
			if(!paymentChannelId.equals(recordPaymentChannelId)) {
				modelResult.withError("0", "改渠道对应支付类型和渠道模板已存在");
				return modelResult;
			}
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
		List<PaymentChannel> list = paymentChannelDao.pageList(start,offset);
		List<PaymentChannel> result = selectChannelName(list);
        dataPage.setDataList(result);
        pageVo.setRows(result);
        pageVo.setTotal(totalCount);
        modelResult.setModel(pageVo);
        return modelResult;
	}

	@Override
	public ModelResult<List<PaymentChannel>> list() {
		ModelResult<List<PaymentChannel>> modelResult = new ModelResult<List<PaymentChannel>>();
		List<PaymentChannel> list = paymentChannelDao.list();
		modelResult.setModel(list);
		return modelResult;
	}

	private List<PaymentChannel> selectChannelName(List<PaymentChannel> list){
		for(PaymentChannel paymentChannel:list) {
			Integer paymentTemplateId = paymentChannel.getPaymentTemplateId();
			PaymentTemplate paymentTemplate = paymentTemplateDao.selectByPrimaryKey(paymentTemplateId);
			if(paymentTemplate != null) {
				paymentChannel.setTemplateName(paymentTemplate.getTemplateDesc());
			}
		}
		return list;
	}
		 
}
