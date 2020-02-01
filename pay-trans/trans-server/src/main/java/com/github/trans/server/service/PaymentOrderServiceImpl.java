package com.github.trans.server.service;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;

import com.github.appmodel.domain.result.ModelResult;
import com.github.trans.common.domain.PaymentOrder;
import com.github.trans.common.service.PaymentOrderService;
import com.github.trans.server.service.dao.PaymentOrderDao;

public class PaymentOrderServiceImpl extends BaseService implements PaymentOrderService{

	@Autowired
	private PaymentOrderDao paymentOrderDao;
	
	@Override
	public ModelResult<Integer> deleteByPrimaryKey(String orderNo) {
		ModelResult<Integer> modelResult = new ModelResult<Integer>();
		if(StringUtils.isBlank(orderNo)) {
			modelResult.withError("0", "订单号为空");
			return modelResult;
		}
		int result = paymentOrderDao.deleteByPrimaryKey(orderNo);
		return this.operation(result);
	}

	@Override
	public ModelResult<Integer> insert(PaymentOrder record) {
		ModelResult<Integer> modelResult = new ModelResult<Integer>();
		if(record == null) {
			modelResult.withError("0", "非法参数");
			return modelResult;
		}
		int result = paymentOrderDao.insert(record);
		return this.operation(result);
	}

	@Override
	public ModelResult<Integer> insertSelective(PaymentOrder record) {
		ModelResult<Integer> modelResult = new ModelResult<Integer>();
		if(record == null) {
			modelResult.withError("0", "非法参数");
			return modelResult;
		}
		int result = paymentOrderDao.insertSelective(record);
		return this.operation(result);
	}

	@Override
	public ModelResult<PaymentOrder> selectByPrimaryKey(String orderNo) {
		ModelResult<PaymentOrder> modelResult = new ModelResult<PaymentOrder>();
		if(StringUtils.isBlank(orderNo)) {
			modelResult.withError("0", "订单号不能为空");
			return modelResult;
		}
		PaymentOrder paymentOrder = paymentOrderDao.selectByPrimaryKey(orderNo);
		modelResult.setModel(paymentOrder);
		return modelResult;
	}

	@Override
	public ModelResult<Integer> updateByPrimaryKeySelective(PaymentOrder record) {
		ModelResult<Integer> modelResult = new ModelResult<Integer>();
		if(record == null) {
			modelResult.withError("0", "非法参数");
			return modelResult;
		}
		int result = paymentOrderDao.updateByPrimaryKeySelective(record);
		return this.operation(result);
	}

	@Override
	public ModelResult<Integer> updateByPrimaryKey(PaymentOrder record) {
		ModelResult<Integer> modelResult = new ModelResult<Integer>();
		if(record == null) {
			modelResult.withError("0", "非法参数");
			return modelResult;
		}
		int result = paymentOrderDao.updateByPrimaryKey(record);
		return this.operation(result);
	}

	@Override
	public ModelResult<PaymentOrder> selectByCstomerOrderNo(String customerOrderNo) {
		ModelResult<PaymentOrder> modelResult = new ModelResult<PaymentOrder>();
		if(StringUtils.isBlank(customerOrderNo)) {
			modelResult.withError("0", "订单号不能为空");
			return modelResult;
		}
		PaymentOrder paymentOrder = paymentOrderDao.selectByCstomerOrderNo(customerOrderNo);
		modelResult.setModel(paymentOrder);
		return modelResult;
	}

}
