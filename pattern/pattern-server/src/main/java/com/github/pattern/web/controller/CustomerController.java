package com.github.pattern.web.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.github.appmodel.domain.result.ModelResult;
import com.github.pattern.common.domain.Customer;
import com.github.pattern.common.request.CustomerRequest;
import com.github.pattern.common.service.CustomerService;
import com.github.pattern.common.vo.ResultVo;

@RestController
@RequestMapping("/pattern/server/customer")
public class CustomerController {
	
	
	@Autowired
	private CustomerService customerServiceImpl;
	
	@PostMapping("/page")
	public ModelResult<ResultVo> page(@RequestBody CustomerRequest request){
		return customerServiceImpl.page(request);
	}
	
	@PostMapping("/deleteByPrimaryKey/{customerId}")
	public ModelResult<Integer> deleteByPrimaryKey(@PathVariable("customerId")Integer customerId){
		return customerServiceImpl.deleteByPrimaryKey(customerId);
	}

	@PostMapping("/insertSelective")
	public ModelResult<Integer> insertSelective(@RequestBody Customer record){
		return customerServiceImpl.insertSelective(record);
	}

	@PostMapping("/selectByPrimaryKey/{customerId}")
	public ModelResult<Customer> selectByPrimaryKey(@PathVariable("customerId")Integer customerId){
		return customerServiceImpl.selectByPrimaryKey(customerId);
	}

	@PostMapping("/updateByPrimaryKeySelective")
	public ModelResult<Integer> updateByPrimaryKeySelective(@RequestBody Customer record){
		return customerServiceImpl.updateByPrimaryKeySelective(record);
	}

	@PostMapping("/updateByPrimaryKey")
	public ModelResult<Integer> updateByPrimaryKey(@RequestBody Customer record){
		return customerServiceImpl.updateByPrimaryKey(record);
	}

}
