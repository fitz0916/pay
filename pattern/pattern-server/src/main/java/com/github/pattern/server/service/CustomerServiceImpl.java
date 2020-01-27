package com.github.pattern.server.service;

import java.util.Date;
import java.util.List;

import org.apache.commons.lang3.RandomStringUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.appmodel.domain.result.ModelResult;
import com.github.appmodel.page.DataPage;
import com.github.pattern.common.constants.PatternConstants;
import com.github.pattern.common.domain.Customer;
import com.github.pattern.common.request.CustomerRequest;
import com.github.pattern.common.service.CustomerService;
import com.github.pattern.common.utils.AmountUtil;
import com.github.pattern.common.utils.UUIDGenerator;
import com.github.pattern.common.vo.PageVo;
import com.github.pattern.server.dao.CustomerDao;


@Service
public class CustomerServiceImpl extends BaseService implements CustomerService{

	@Autowired
	private CustomerDao customerDao;
	
	@Override
	public ModelResult<Integer> deleteByPrimaryKey(Integer customerId) {
		 ModelResult<Integer> modelResult = new  ModelResult<Integer>();
		 if(customerId == null || customerId == 0) {
			 modelResult.withError("0", "非法参数");
			 return modelResult;
		 }
		 Customer customer = new Customer();
		 customer.setCustomerId(customerId);
		 customer.setUpdateDate(new Date());
		 customer.setStatus(2);
		 int result = customerDao.updateByPrimaryKeySelective(customer);
		 if(result > 0) {
			 modelResult.setModel(result);
		 }else {
			 modelResult.withError("0", "删除失败");
		 }
		return modelResult;
	}

	@Override
	public ModelResult<Integer> insertSelective(Customer record) {
		 ModelResult<Integer> modelResult = new  ModelResult<Integer>();
		 if(record == null) {
			 modelResult.withError("0", "非法参数");
			 return modelResult;
		 }
		 String customerNo = PatternConstants.CUSTOMER_NO_PREFX + UUIDGenerator.getRandomNumber(6);
		 String cipher = RandomStringUtils.random(6);
		 record.setAmount("0");
		 record.setFrozenAmount("0");
		 record.setFrozenAmountSum("0");
		 record.setCustomerNo(customerNo);
		 record.setCreateDate(new Date());
		 record.setUpdateDate(new Date());
		 record.setCipher(cipher);
		 String customerName = record.getCustomerName();
		 Customer customer = customerDao.selectByCustomerName(customerName);
		 if(customer != null) {
			 modelResult.withError("0", "商户名称已存在！");
			 return modelResult;
		 }
		 int result = customerDao.insertSelective(record);
		 if(result > 0) {
			 modelResult.setModel(result);
		 }else {
			 modelResult.withError("0", "添加失败");
		 }
		return modelResult;
	}

	@Override
	public ModelResult<Customer> selectByPrimaryKey(Integer customerId) {
		 ModelResult<Customer> modelResult = new  ModelResult<Customer>();
		 if(customerId == null || customerId == 0) {
			 modelResult.withError("0", "非法参数");
			 return modelResult;
		 }
		 Customer customer = customerDao.selectByPrimaryKey(customerId);
		 if(customer != null) {
		 	customer.setAmount(AmountUtil.changeF2Y(customer.getAmount().toString()));
			customer.setFrozenAmount(AmountUtil.changeF2Y(customer.getFrozenAmount().toString()));
			customer.setUnfreezeAmount(AmountUtil.changeF2Y(customer.getUnfreezeAmount().toString()));
			customer.setFrozenAmountSum(AmountUtil.changeF2Y(customer.getFrozenAmountSum().toString()));
			customer.setSettlement(AmountUtil.changeF2Y(customer.getSettlement().toString()));
		 }
		 modelResult.setModel(customer);
		 return modelResult;
	}

	@Override
	public ModelResult<Integer> updateByPrimaryKeySelective(Customer record) {
		ModelResult<Integer> modelResult = new  ModelResult<Integer>();
		 if(record == null || record.getCustomerId() == null || record.getCustomerId() == 0) {
			 modelResult.withError("0", "非法参数");
			 return modelResult;
		 }
		 record.setUpdateDate(new Date());
		 String customerName = record.getCustomerName();
		 Customer customer = customerDao.selectByCustomerName(customerName);
		 if(customer != null) {
			 String updateCustomerId = String.valueOf(record.getCustomerId());
			 String customerId = String.valueOf(customer.getCustomerId());
			 if(!updateCustomerId.equals(customerId)) {
				 modelResult.withError("0", "商户名称已存在！");
				 return modelResult;
			 }
		 }
//		 record.setAmount(AmountUtil.changeY2F(record.getAmount())); 
//		 record.setFrozenAmount(AmountUtil.changeY2F(record.getFrozenAmount()));
//		 record.setUnfreezeAmount(AmountUtil.changeY2F(customer.getUnfreezeAmount()));
//		 record.setFrozenAmountSum(AmountUtil.changeY2F(customer.getFrozenAmountSum()));
//		 record.setSettlement(AmountUtil.changeY2F(customer.getSettlement()));
		 int result = customerDao.updateByPrimaryKeySelective(record);
		 if(result > 0) {
			 modelResult.setModel(result);
		 }else {
			 modelResult.withError("0", "编辑失败");
		 }
		return modelResult;
	}

	@Override
	public ModelResult<Integer> updateByPrimaryKey(Customer record) {
		ModelResult<Integer> modelResult = new  ModelResult<Integer>();
		 if(record == null || record.getCustomerId() == null || record.getCustomerId() == 0) {
			 modelResult.withError("0", "非法参数");
			 return modelResult;
		 }
		 record.setUpdateDate(new Date());
		 String customerName = record.getCustomerName();
		 Customer customer = customerDao.selectByCustomerName(customerName);
		 if(customer != null) {
			 String updateCustomerId = String.valueOf(record.getCustomerId());
			 String customerId = String.valueOf(customer.getCustomerId());
			 if(!updateCustomerId.equals(customerId)) {
				 modelResult.withError("0", "商户名称已存在！");
				 return modelResult;
			 }
		 }
		 int result = customerDao.updateByPrimaryKey(record);
		 if(result > 0) {
			 modelResult.setModel(result);
		 }else {
			 modelResult.withError("0", "编辑失败");
		 }
		return modelResult;
	}

	@Override
	public ModelResult<PageVo> page(CustomerRequest request) {
		ModelResult<PageVo> modelResult = new ModelResult<PageVo>();
		PageVo pageVo = new PageVo();
		Integer shopId = request.getShopId();
		DataPage<Customer> dataPage = new DataPage<Customer>();
		this.setDataPage(dataPage, request);;
		List<Integer> statusList = this.buildStatusList();
		int start = dataPage.getStartIndex();
		int offset = dataPage.getPageSize();
		long totalCount = customerDao.pageCount(statusList,shopId);
		List<Customer> list = customerDao.pageList(start,offset,statusList,shopId);
		List<Customer> result = changeF2Y(list);
        dataPage.setDataList(result);
        pageVo.setRows(result);
        pageVo.setTotal(totalCount);
        modelResult.setModel(pageVo);
        return modelResult;
		
	}
	
	private List<Customer> changeF2Y(List<Customer> result){
		for(Customer customer:result) {
			customer.setAmount(AmountUtil.changeF2Y(customer.getAmount().toString()));
			customer.setFrozenAmount(AmountUtil.changeF2Y(customer.getFrozenAmount().toString()));
			customer.setUnfreezeAmount(AmountUtil.changeF2Y(customer.getUnfreezeAmount().toString()));
			customer.setFrozenAmountSum(AmountUtil.changeF2Y(customer.getFrozenAmountSum().toString()));
			customer.setSettlement(AmountUtil.changeF2Y(customer.getSettlement().toString()));
		}
		return result;
	}

	@Override
	public ModelResult<Customer> selectByCustomerNo(String customerNo) {
		ModelResult<Customer> modelResult = new ModelResult<Customer>();
		if(StringUtils.isBlank(customerNo)) {
			modelResult.withError("0","商户号为空");
			return modelResult;
		}
		Customer customer = customerDao.selectByCustomerNo(customerNo);
		modelResult.setModel(customer);
		return modelResult;
	}

}
