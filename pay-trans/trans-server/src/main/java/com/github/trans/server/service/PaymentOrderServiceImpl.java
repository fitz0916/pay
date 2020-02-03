package com.github.trans.server.service;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.appmodel.domain.result.ModelResult;
import com.github.appmodel.page.DataPage;
import com.github.appmodel.vo.PageVo;
import com.github.pattern.common.utils.AmountUtil;
import com.github.trans.common.domain.PaymentOrder;
import com.github.trans.common.request.PaymentOrderRequest;
import com.github.trans.common.service.PaymentOrderService;
import com.github.trans.server.dao.PaymentOrderDao;
import com.github.trans.server.service.base.BaseService;

@Service
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
	public ModelResult<List<PaymentOrder>> selectByCstomerOrderNo(String customerOrderNo) {
		ModelResult<List<PaymentOrder>> modelResult = new ModelResult<List<PaymentOrder>>();
		if(StringUtils.isBlank(customerOrderNo)) {
			modelResult.withError("0", "订单号不能为空");
			return modelResult;
		}
		List<PaymentOrder> paymentOrder = paymentOrderDao.selectByCstomerOrderNo(customerOrderNo);
		modelResult.setModel(paymentOrder);
		return modelResult;
	}

	@Override
	public ModelResult<PageVo> page(PaymentOrderRequest request) {
		ModelResult<PageVo> modelResult = new ModelResult<PageVo>();
		PageVo pageVo = new PageVo();
		DataPage<PaymentOrder> dataPage = new DataPage<PaymentOrder>();
		this.setDataPage(dataPage, request);;
		int start = dataPage.getStartIndex();
		int offset = dataPage.getPageSize();
		String customerNo = request.getCustomerNo();
		String customerOrderNo = request.getCustomerOrderNo();
		long totalCount = paymentOrderDao.pageCount(customerNo,customerOrderNo);
		List<PaymentOrder> result = changeF2Y(paymentOrderDao.pageList(start,offset,customerNo,customerOrderNo));
        dataPage.setDataList(result);
        pageVo.setRows(result);
        pageVo.setTotal(totalCount);
        modelResult.setModel(pageVo);
        return modelResult;
	}

	private List<PaymentOrder> changeF2Y(List<PaymentOrder> list){
		for(PaymentOrder paymentOrder:list) {
			paymentOrder.setPayAmount(AmountUtil.changeF2Y(paymentOrder.getPayAmount()));
			paymentOrder.setCustomerAmount(AmountUtil.changeF2Y(paymentOrder.getCustomerAmount()));
			paymentOrder.setAgentProundage(AmountUtil.changeF2Y(paymentOrder.getAgentProundage()));
			paymentOrder.setThirdChannelProundage(AmountUtil.changeF2Y(paymentOrder.getThirdChannelProundage()));
			paymentOrder.setCustomerProundage(AmountUtil.changeF2Y(paymentOrder.getCustomerProundage()));
		}
		return list;
	}
}
