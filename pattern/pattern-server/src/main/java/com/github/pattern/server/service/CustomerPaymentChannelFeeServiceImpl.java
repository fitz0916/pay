package com.github.pattern.server.service;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.appmodel.domain.result.ModelResult;
import com.github.pattern.common.domain.CustomerPaymentChannelFee;
import com.github.pattern.common.request.CustomerPaymentChannelFeeRequest;
import com.github.pattern.common.service.CustomerChannelFeeService;
import com.github.pattern.common.vo.ResultVo;
import com.github.pattern.server.dao.CustomerPaymentChannelFeeDao;


@Service
public class CustomerPaymentChannelFeeServiceImpl extends BaseService implements CustomerChannelFeeService{

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
		if(record == null) {
			modelResult.withError("0", "非法参数");
			return modelResult;
		}
		Date date = new Date();
		record.setCreateTime(date);
		record.setUpdateTime(date);
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
		// TODO Auto-generated method stub
		return null;
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
	
	

}
