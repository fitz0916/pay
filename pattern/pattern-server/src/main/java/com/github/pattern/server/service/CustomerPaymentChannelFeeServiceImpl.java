package com.github.pattern.server.service;

import java.math.BigDecimal;
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
		modelResult = this.compareRate(record);
		if(!modelResult.isSuccess()) {
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

	private ModelResult<Integer> compareRate(CustomerPaymentChannelFee record){
		ModelResult<Integer> modelResult = new ModelResult<Integer>();
		BigDecimal thirdRate = record.getThirdRate();
		BigDecimal agentRate = record.getAgentRate();
		BigDecimal shopRate = record.getShopRate();
		BigDecimal customerRate = record.getCustomerRate();
		if(thirdRate == null || agentRate == null || shopRate == null || customerRate == null) {
			modelResult.withError("0", "接入、代理商、门店、商户费率不能为空!");
			return modelResult;
		}
		boolean agentAndThirdCompare = (thirdRate.compareTo(agentRate) < -1 || thirdRate.compareTo(agentRate) == 0);
		
		boolean shopAndAgentCompare = (agentRate.compareTo(shopRate) < -1 || agentRate.compareTo(shopRate) == 0);
		boolean shopAndThirdCompare = (shopRate.compareTo(thirdRate) < -1 || shopRate.compareTo(thirdRate) == 0);
		
		boolean customerAndThirdCompare = (thirdRate.compareTo(customerRate) < -1 || thirdRate.compareTo(customerRate) == 0);
		boolean customerAndAgentCompare = (agentRate.compareTo(customerRate) < -1 || agentRate.compareTo(customerRate) == 0);
		boolean customerAndShopCompare = (shopRate.compareTo(customerRate) < -1 || shopRate.compareTo(customerRate) == 0);
		
		if(agentAndThirdCompare) {
			modelResult.withError("0", "代理商费率不能小于或等于接入费率");
			return modelResult;
		}
		if(shopAndAgentCompare || shopAndThirdCompare) {
			modelResult.withError("0", "门店费率不能小于或等于代理商、接入费率");
			return modelResult;
		}
		if(customerAndThirdCompare || customerAndAgentCompare || customerAndShopCompare) {
			modelResult.withError("0", "商户费率不能小于或等于门店、代理商、接入费率");
			return modelResult;
		}
		return modelResult;
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
