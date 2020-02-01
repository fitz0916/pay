package com.github.pattern.server.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.appmodel.domain.result.ModelResult;
import com.github.appmodel.vo.ResultVo;
import com.github.pattern.common.domain.PaymentChannelAccount;
import com.github.pattern.common.request.PaymentChannelAccountRequest;
import com.github.pattern.common.service.PaymentChannelAccountService;
import com.github.pattern.server.dao.PaymentChannelAccountDao;

@Service
public class PaymentChannelAccountServiceImpl extends BaseService implements PaymentChannelAccountService {

	@Autowired
	private PaymentChannelAccountDao paymentChannelAccountDao;

	@Override
	public ModelResult<Integer> deleteByPrimaryKey(Integer paymentChannelAccountId) {
		ModelResult<Integer> modelResult = new ModelResult<Integer>();
		if (paymentChannelAccountId == null || paymentChannelAccountId == 0) {
			modelResult.withError("0", "非法参数");
			return modelResult;
		}
		int result = paymentChannelAccountDao.deleteByPrimaryKey(paymentChannelAccountId);
		return this.operation(result);
	}

	@Override
	public ModelResult<Integer> insertSelective(PaymentChannelAccount record) {
		ModelResult<Integer> modelResult = new ModelResult<Integer>();
		if (record == null || record.getPaymentChannelId() == null || record.getPaymentChannelId() == 0) {
			modelResult.withError("0", "非法参数");
			return modelResult;
		}
		Date date = new Date();
		record.setCreateTime(date);
		record.setUpdateTime(date);
		int result = paymentChannelAccountDao.insertSelective(record);
		return this.operation(result);
	}

	@Override
	public ModelResult<PaymentChannelAccount> selectByPrimaryKey(Integer paymentChannelAccountId) {
		ModelResult<PaymentChannelAccount> modelResult = new ModelResult<PaymentChannelAccount>();
		if (paymentChannelAccountId == null || paymentChannelAccountId == 0) {
			modelResult.withError("0", "非法参数");
			return modelResult;
		}
		PaymentChannelAccount paymentChannelAccount = paymentChannelAccountDao.selectByPrimaryKey(paymentChannelAccountId);
		modelResult.setModel(paymentChannelAccount);
		return modelResult;
	}

	@Override
	public ModelResult<Integer> updateByPrimaryKeySelective(PaymentChannelAccount record) {
		ModelResult<Integer> modelResult = new ModelResult<Integer>();
		if (record == null ||  record.getPaymentChannelId() == 0) {
			modelResult.withError("0", "非法参数");
			return modelResult;
		}
		record.setUpdateTime(new Date());
		int result = paymentChannelAccountDao.updateByPrimaryKeySelective(record);
		return this.operation(result);
	}

	@Override
	public ModelResult<Integer> updateByPrimaryKey(PaymentChannelAccount record) {
		ModelResult<Integer> modelResult = new ModelResult<Integer>();
		if (record == null ||  record.getPaymentChannelId() == 0) {
			modelResult.withError("0", "非法参数");
			return modelResult;
		}
		record.setUpdateTime(new Date());
		int result = paymentChannelAccountDao.updateByPrimaryKey(record);
		return this.operation(result);
	}

	@Override
	public ModelResult<ResultVo> page(PaymentChannelAccountRequest request) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ModelResult<List<PaymentChannelAccount>> selectByPaymentChannelId(Integer paymentChannelId) {
		ModelResult<List<PaymentChannelAccount>> modelResult = new ModelResult<List<PaymentChannelAccount>>();
		if(paymentChannelId == null || paymentChannelId == 0) {
			modelResult.withError("0", "非法参数");
			return modelResult;
		}
		List<PaymentChannelAccount> list = paymentChannelAccountDao.selectByPaymentChannelId(paymentChannelId);
		modelResult.setModel(list);
		return modelResult;
	}

}
