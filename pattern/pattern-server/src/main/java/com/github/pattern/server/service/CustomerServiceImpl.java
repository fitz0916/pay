package com.github.pattern.server.service;

import java.util.Date;
import java.util.List;

import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.appmodel.domain.result.ModelResult;
import com.github.appmodel.page.DataPage;
import com.github.pattern.common.constants.PatternConstants;
import com.github.pattern.common.domain.Customer;
import com.github.pattern.common.request.CustomerRequest;
import com.github.pattern.common.service.CustomerService;
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
		 record.setCustomerNo(customerNo);
		 record.setCreateDate(new Date());
		 record.setUpdateDate(new Date());
		 record.setCipher(cipher);
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
		List<Customer> result = customerDao.pageList(start,offset,statusList,shopId);
        dataPage.setDataList(result);
        pageVo.setRows(result);
        pageVo.setTotal(totalCount);
        modelResult.setModel(pageVo);
        return modelResult;
		
	}
	
	

}
