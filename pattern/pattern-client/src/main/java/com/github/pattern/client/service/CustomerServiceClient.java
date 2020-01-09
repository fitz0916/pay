package com.github.pattern.client.service;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.github.appmodel.domain.result.ModelResult;
import com.github.pattern.common.domain.Customer;
import com.github.pattern.common.request.CustomerRequest;
import com.github.pattern.common.vo.PageVo;

@FeignClient(name="pattern-server")
@RequestMapping("/pattern/server/customer")
public interface CustomerServiceClient {
	
	
	@PostMapping("/page")
	ModelResult<PageVo> page(@RequestBody CustomerRequest request);
	
	@PostMapping("/deleteByPrimaryKey/{customerId}")
	ModelResult<Integer> deleteByPrimaryKey(@PathVariable("customerId")Integer customerId);

	@PostMapping("/insertSelective")
	ModelResult<Integer> insertSelective(@RequestBody Customer record);

	@PostMapping("/selectByPrimaryKey/{customerId}")
	ModelResult<Customer> selectByPrimaryKey(@PathVariable("customerId")Integer customerId);

	@PostMapping("/updateByPrimaryKeySelective")
	ModelResult<Integer> updateByPrimaryKeySelective(@RequestBody Customer record);

	@PostMapping("/updateByPrimaryKey")
	ModelResult<Integer> updateByPrimaryKey(@RequestBody Customer record);

}
