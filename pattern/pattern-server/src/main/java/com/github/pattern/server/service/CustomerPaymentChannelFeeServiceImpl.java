package com.github.pattern.server.service;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.appmodel.domain.result.ModelResult;
import com.github.appmodel.vo.ResultVo;
import com.github.pattern.common.domain.CustomerPaymentChannelFee;
import com.github.pattern.common.request.CustomerPaymentChannelFeeRequest;
import com.github.pattern.common.service.CustomerPaymentChannelFeeService;
import com.github.pattern.server.dao.CustomerPaymentChannelFeeDao;


@Service
public class CustomerPaymentChannelFeeServiceImpl extends BaseService implements CustomerPaymentChannelFeeService{

	@Autowired
	private CustomerPaymentChannelFeeDao customerPaymentChannelFeeDao;
	
	
	@Override
	public ModelResult<Integer> deleteByPrimaryKey(Integer paymentChanneldFeeId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ModelResult<Integer> insert(CustomerPaymentChannelFee record) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ModelResult<Integer> insertSelective(CustomerPaymentChannelFee record) {
		ModelResult<Integer> modelResult = new ModelResult<Integer>();
		if(record == null || record.getCustomerId() == null || record.getPaymentChannelId() == null) {
			modelResult.withError("0", "非法参数");
			return modelResult;
		}
		Date date = new Date();
		record.setCreateTime(date);
		record.setUpdateTime(date);
		Integer customerId = record.getCustomerId();
		Integer paymentChannelId = record.getPaymentChannelId();
		CustomerPaymentChannelFee customerPaymentChannelFee = customerPaymentChannelFeeDao.selectByCustomerIdAndPaymentChannelId(customerId, paymentChannelId);
		if(customerPaymentChannelFee != null) {
			modelResult.withError("0", "改商户渠道已经设置费率");
			return modelResult;
		}
		int result = customerPaymentChannelFeeDao.insertSelective(record);
		return this.operation(result);
	}

	@Override
	public ModelResult<CustomerPaymentChannelFee> selectByPrimaryKey(Integer paymentChanneldFeeId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ModelResult<Integer> updateByPrimaryKeySelective(CustomerPaymentChannelFee record) {
		ModelResult<Integer> modelResult = new ModelResult<Integer>();
		if(record == null || record.getCustomerId() == null || record.getPaymentChannelId() == null) {
			modelResult.withError("0", "非法参数");
			return modelResult;
		}
		Date date = new Date();
		record.setUpdateTime(date);
		Integer customerId = record.getCustomerId();
		Integer paymentChannelId = record.getPaymentChannelId();
		CustomerPaymentChannelFee customerPaymentChannelFee = customerPaymentChannelFeeDao.selectByCustomerIdAndPaymentChannelId(customerId, paymentChannelId);
		if(customerPaymentChannelFee != null) {
			int recordId = record.getPaymentChanneldFeeId().intValue();
			int paymentChannelFeeId = customerPaymentChannelFee.getPaymentChanneldFeeId().intValue();
			if(recordId != paymentChannelFeeId) {
				modelResult.withError("0", "改商户渠道已经设置费率");
				return modelResult;
			}
		}
		int result = customerPaymentChannelFeeDao.updateByPrimaryKeySelective(record);
		return this.operation(result);
	}

	@Override
	public ModelResult<Integer> updateByPrimaryKey(CustomerPaymentChannelFee record) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ModelResult<ResultVo> page(CustomerPaymentChannelFeeRequest request) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ModelResult<CustomerPaymentChannelFee> selectByCustomerIdAndPaymentChannelId(Integer customerId,Integer paymentChannelId) {
		ModelResult<CustomerPaymentChannelFee> modelResult = new ModelResult<CustomerPaymentChannelFee>();
		if(customerId == null || paymentChannelId == null) {
			modelResult.withError("0", "非法参数");
			return modelResult;
		}
		CustomerPaymentChannelFee customerPaymentChannelFee = customerPaymentChannelFeeDao.selectByCustomerIdAndPaymentChannelId(customerId, paymentChannelId);
		modelResult.setModel(customerPaymentChannelFee);
		return modelResult;
	}
	
	

}
