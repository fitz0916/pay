package com.github.pattern.server.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.appmodel.domain.result.ModelResult;
import com.github.pattern.common.domain.PaymentChannelAccountPara;
import com.github.pattern.common.request.PaymentChannelAccountParaRequest;
import com.github.pattern.common.service.PaymentChannelAccountParaService;
import com.github.pattern.common.vo.ResultVo;
import com.github.pattern.server.dao.PaymentChannelAccountParaDao;


@Service
public class PaymentChannelAccountParaServiceImpl extends BaseService implements PaymentChannelAccountParaService{

	@Autowired
	private PaymentChannelAccountParaDao paymentChannelAccountParaDao;
	
	@Override
	public ModelResult<Integer> deleteByPrimaryKey(Integer paymentChannelAccountParaId) {
		ModelResult<Integer> modelResult = new ModelResult<Integer>();
		if(paymentChannelAccountParaId == null || paymentChannelAccountParaId == 0) {
			modelResult.withError("0", "非法参数");
			return modelResult;
		}
		int result = paymentChannelAccountParaDao.deleteByPrimaryKey(paymentChannelAccountParaId);
		return this.operation(result);
	}

	@Override
	public ModelResult<Integer> insert(PaymentChannelAccountPara record) {
		ModelResult<Integer> modelResult = new ModelResult<Integer>();
		if(record == null || record.getPaymentChannelAccountId() == null || record.getPaymentChannelAccountId() == 0) {
			modelResult.withError("0", "非法参数");
			return modelResult;
		}
		int result = paymentChannelAccountParaDao.insert(record);
		return this.operation(result);
	}

	@Override
	public ModelResult<Integer> insertSelective(PaymentChannelAccountPara record) {
		ModelResult<Integer> modelResult = new ModelResult<Integer>();
		if(record == null || record.getPaymentChannelAccountId() == null || record.getPaymentChannelAccountId() == 0) {
			modelResult.withError("0", "非法参数");
			return modelResult;
		}
		int result = paymentChannelAccountParaDao.insertSelective(record);
		return this.operation(result);
	}

	@Override
	public ModelResult<PaymentChannelAccountPara> selectByPrimaryKey(Integer paymentChannelAccountParaId) {
		ModelResult<PaymentChannelAccountPara> modelResult = new ModelResult<PaymentChannelAccountPara>();
		if(paymentChannelAccountParaId == null || paymentChannelAccountParaId == 0) {
			modelResult.withError("0", "非法参数");
			return modelResult;
		}
		PaymentChannelAccountPara paymentChannelAccountPara = paymentChannelAccountParaDao.selectByPrimaryKey(paymentChannelAccountParaId);
		modelResult.setModel(paymentChannelAccountPara);
		return modelResult;
	}

	@Override
	public ModelResult<Integer> updateByPrimaryKeySelective(PaymentChannelAccountPara record) {
		ModelResult<Integer> modelResult = new ModelResult<Integer>();
		if(record == null || record.getPaymentChannelAccountParaId() == null || record.getPaymentChannelAccountId() == null || record.getPaymentChannelAccountId() == 0) {
			modelResult.withError("0", "非法参数");
			return modelResult;
		}
		int result = paymentChannelAccountParaDao.updateByPrimaryKeySelective(record);
		return this.operation(result);
	}

	@Override
	public ModelResult<Integer> updateByPrimaryKey(PaymentChannelAccountPara record) {
		ModelResult<Integer> modelResult = new ModelResult<Integer>();
		if(record == null || record.getPaymentChannelAccountParaId() == null || record.getPaymentChannelAccountId() == null || record.getPaymentChannelAccountId() == 0) {
			modelResult.withError("0", "非法参数");
			return modelResult;
		}
		int result = paymentChannelAccountParaDao.updateByPrimaryKey(record);
		return this.operation(result);
	}

	@Override
	public ModelResult<List<PaymentChannelAccountPara>> selectByPaymentChannelAccountId(Integer paymentChannelAccountId) {
		ModelResult<List<PaymentChannelAccountPara>> modelResult = new ModelResult<List<PaymentChannelAccountPara>>();
		if(paymentChannelAccountId == null || paymentChannelAccountId == 0) {
			modelResult.withError("0", "非法参数");
			return modelResult;
		}
		List<PaymentChannelAccountPara> list = paymentChannelAccountParaDao.selectByPaymentChannelAccountId(paymentChannelAccountId);
		modelResult.setModel(list);
		return modelResult;
	}

	

}
