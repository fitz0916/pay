package com.github.pattern.web.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.github.appmodel.domain.result.ModelResult;
import com.github.pattern.common.domain.CustomerPaymentChannelFee;
import com.github.pattern.common.request.CustomerPaymentChannelFeeRequest;
import com.github.pattern.common.service.CustomerPaymentChannelFeeService;
import com.github.pattern.common.vo.ResultVo;

@RestController
@RequestMapping("/pattern/server/customerChannelFee")
public class CustomerPaymentChannelFeeController {
	
	
	@Autowired
	private CustomerPaymentChannelFeeService customerChannelFeeServiceImpl;
	
	@PostMapping("/page")
	public ModelResult<ResultVo> page(@RequestBody CustomerPaymentChannelFeeRequest request){
		return customerChannelFeeServiceImpl.page(request);
	}
	
	@PostMapping("/deleteByPrimaryKey/{paymentChanneldFeeId}")
	public ModelResult<Integer> deleteByPrimaryKey(@PathVariable("paymentChanneldFeeId")Integer paymentChanneldFeeId){
		return customerChannelFeeServiceImpl.deleteByPrimaryKey(paymentChanneldFeeId);
	}

	@PostMapping("/insert")
	public ModelResult<Integer> insert(@RequestBody CustomerPaymentChannelFee record){
		return customerChannelFeeServiceImpl.insert(record);
	}

	@PostMapping("/insertSelective")
	public ModelResult<Integer> insertSelective(@RequestBody CustomerPaymentChannelFee record){
		return customerChannelFeeServiceImpl.insertSelective(record);
	}

	@PostMapping("/selectByPrimaryKey/{paymentChanneldFeeId}")
	public ModelResult<CustomerPaymentChannelFee> selectByPrimaryKey(@PathVariable("paymentChanneldFeeId")Integer paymentChanneldFeeId){
		return customerChannelFeeServiceImpl.selectByPrimaryKey(paymentChanneldFeeId);
	}

	@PostMapping("/updateByPrimaryKeySelective")
	public  ModelResult<Integer> updateByPrimaryKeySelective(@RequestBody CustomerPaymentChannelFee record){
		return customerChannelFeeServiceImpl.updateByPrimaryKeySelective(record);
	}

	@PostMapping("/updateByPrimaryKey")
	public ModelResult<Integer> updateByPrimaryKey(@RequestBody CustomerPaymentChannelFee record){
		return customerChannelFeeServiceImpl.updateByPrimaryKey(record);
	}

	@PostMapping("/selectByCustomerIdAndPaymentChannelId/{customerId}/{paymentChannelId}")
	ModelResult<CustomerPaymentChannelFee> selectByCustomerIdAndPaymentChannelId(@PathVariable("customerId")Integer customerId,@PathVariable("paymentChannelId")Integer paymentChannelId){
		return customerChannelFeeServiceImpl.selectByCustomerIdAndPaymentChannelId(customerId,paymentChannelId);
	}
}
