package com.github.pattern.server.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.appmodel.domain.result.ModelResult;
import com.github.appmodel.page.DataPage;
import com.github.pattern.common.domain.Customer;
import com.github.pattern.common.domain.CustomerPaymentChannelInfo;
import com.github.pattern.common.domain.PaymentChannel;
import com.github.pattern.common.request.CustomerPaymentChannelInfoRequest;
import com.github.pattern.common.service.CustomerPaymentChannelInfoService;
import com.github.pattern.common.vo.PageVo;
import com.github.pattern.server.dao.CustomerDao;
import com.github.pattern.server.dao.CustomerPaymentChannelInfoDao;
import com.github.pattern.server.dao.PaymentChannelDao;


@Service
public class CustomerPaymentChannelInfoServiceImpl extends BaseService implements CustomerPaymentChannelInfoService{
	
	@Autowired
	private CustomerDao customerDao;
	
	@Autowired
	private CustomerPaymentChannelInfoDao customerPaymentChannelInfoDao;
	
	@Autowired
	private PaymentChannelDao paymentChannelDao;

	@Override
	public ModelResult<Integer> deleteByPrimaryKey(Integer customerPaymentChannelInfoId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ModelResult<Integer> insertSelective(CustomerPaymentChannelInfo record) {
		ModelResult<Integer> modelResult = new ModelResult<Integer>();
		if(record == null || record.getPaymentChannelId() == null || record.getCustomerId() == null) {
			modelResult.withError("0", "非法参数");
			return modelResult;
		}
		Integer customerId = record.getCustomerId();
		Integer paymentChannelId = record.getPaymentChannelId();
		CustomerPaymentChannelInfo channelInfo = customerPaymentChannelInfoDao.selectByCustomerIdAndPaymentChannelId(customerId, paymentChannelId);
		if(channelInfo != null && channelInfo.getCustomerPaymentChannelInfoId() != null) {
			modelResult.withError("0", "当前支付渠道已存在，请选择其他支付渠道");
			return modelResult;
		}
		Date date = new Date();
		record.setCreateTime(date);
		record.setUpdateTime(date);
		int result = customerPaymentChannelInfoDao.insertSelective(record);
		return this.operation(result);
	}

	@Override
	public ModelResult<CustomerPaymentChannelInfo> selectByPrimaryKey(Integer customerPaymentChannelInfoId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ModelResult<Integer> updateByPrimaryKeySelective(CustomerPaymentChannelInfo record) {
		ModelResult<Integer> modelResult = new ModelResult<Integer>();
		if(record == null || record.getCustomerPaymentChannelInfoId() == null) {
			modelResult.withError("0", "非法参数");
			return modelResult;
		}
		Integer customerId = record.getCustomerId();
		Integer paymentChannelId = record.getPaymentChannelId();
		CustomerPaymentChannelInfo channelInfo = customerPaymentChannelInfoDao.selectByCustomerIdAndPaymentChannelId(customerId, paymentChannelId);
		if(channelInfo != null && channelInfo.getCustomerPaymentChannelInfoId() != null) {
			modelResult.withError("0", "当前支付渠道已存在，请选择其他支付渠道");
			return modelResult;
		}
		Date date = new Date();
		record.setUpdateTime(date);
		int result = customerPaymentChannelInfoDao.updateByPrimaryKeySelective(record);
		return this.operation(result);
	}

	@Override
	public ModelResult<Integer> updateByPrimaryKey(CustomerPaymentChannelInfo record) {
		ModelResult<Integer> modelResult = new ModelResult<Integer>();
		if(record == null || record.getCustomerPaymentChannelInfoId() == null) {
			modelResult.withError("0", "非法参数");
			return modelResult;
		}
		Integer customerId = record.getCustomerId();
		Integer paymentChannelId = record.getPaymentChannelId();
		CustomerPaymentChannelInfo channelInfo = customerPaymentChannelInfoDao.selectByCustomerIdAndPaymentChannelId(customerId, paymentChannelId);
		if(channelInfo != null && channelInfo.getCustomerPaymentChannelInfoId() != null) {
			modelResult.withError("0", "当前支付渠道已存在，请选择其他支付渠道");
			return modelResult;
		}
		Date date = new Date();
		record.setUpdateTime(date);
		int result = customerPaymentChannelInfoDao.updateByPrimaryKey(record);
		return this.operation(result);
	}

	@Override
	public ModelResult<PageVo> page(CustomerPaymentChannelInfoRequest request) {
		ModelResult<PageVo> modelResult = new ModelResult<PageVo>();
		PageVo pageVo = new PageVo();
		Integer shopId = request.getShopId();
		DataPage<Customer> dataPage = new DataPage<Customer>();
		this.setDataPage(dataPage, request);;
		List<Integer> statusList = this.buildStatusList();
		int start = dataPage.getStartIndex();
		int offset = dataPage.getPageSize();
		long totalCount = customerDao.pageCount(statusList,shopId);
		List<Customer> result = customerDao.pageList(start,offset,statusList,shopId);
		setCustomerChannelInfo(result);
        dataPage.setDataList(result);
        pageVo.setRows(result);
        pageVo.setTotal(totalCount);
        modelResult.setModel(pageVo);
        return modelResult;
	}
	
	private void setCustomerChannelInfo(List<Customer> result) {
		for(Customer customer:result) {
			Integer customerId = customer.getCustomerId();
			if(customerId == null) {
				customer.setPayChannelStatus(0);
				customer.setPayChannelNum(0L);
				continue;
			}
			long payChannelNum = customerPaymentChannelInfoDao.selectPaymentChannelInfoByCustomerId(customerId);
			if(payChannelNum > 0) {
				customer.setPayChannelStatus(1);
				customer.setPayChannelNum(payChannelNum);
			}else {
				customer.setPayChannelStatus(0);
				customer.setPayChannelNum(0L);
			}
		}
	}

	@Override
	public ModelResult<PageVo> paymentChannelInfoPage(CustomerPaymentChannelInfoRequest request) {
		ModelResult<PageVo> modelResult = new ModelResult<PageVo>();
		PageVo pageVo = new PageVo();
		Integer customerId = request.getCustomerId();
		DataPage<CustomerPaymentChannelInfo> dataPage = new DataPage<CustomerPaymentChannelInfo>();
		this.setDataPage(dataPage, request);;
		int start = dataPage.getStartIndex();
		int offset = dataPage.getPageSize();
		long totalCount = customerPaymentChannelInfoDao.selectPaymentChannelInfoByCustomerId(customerId);
		List<CustomerPaymentChannelInfo> result = customerPaymentChannelInfoDao.pageList(start,offset,customerId);
		this.setPaymentChannel(result);
        dataPage.setDataList(result);
        pageVo.setRows(result);
        pageVo.setTotal(totalCount);
        modelResult.setModel(pageVo);
        return modelResult;
	}

	private void setPaymentChannel(List<CustomerPaymentChannelInfo> result) {
		for(CustomerPaymentChannelInfo info:result) {
			Integer paymentChannelId = info.getPaymentChannelId();
			PaymentChannel paymentChannel = paymentChannelDao.selectByPrimaryKey(paymentChannelId);
			info.setPaymentChannel(paymentChannel);
		}
	}
}
