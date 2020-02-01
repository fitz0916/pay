package com.github.pattern.client.service;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.github.appmodel.domain.result.ModelResult;
import com.github.appmodel.vo.ResultVo;
import com.github.pattern.common.domain.CustomerPaymentChannelFee;
import com.github.pattern.common.request.CustomerPaymentChannelFeeRequest;

@FeignClient(name="pattern-server")
@RequestMapping("/pattern/server/customerChannelFee")
public interface CustomerPaymentChannelFeeServiceClient {
	
	@PostMapping("/page")
	ModelResult<ResultVo> page(@RequestBody CustomerPaymentChannelFeeRequest request);
	
	@PostMapping("/deleteByPrimaryKey/{paymentChanneldFeeId}")
	ModelResult<Integer> deleteByPrimaryKey(@PathVariable("paymentChanneldFeeId")Integer paymentChanneldFeeId);

	@PostMapping("/insert")
	ModelResult<Integer> insert(@RequestBody CustomerPaymentChannelFee record);

	@PostMapping("/insertSelective")
	ModelResult<Integer> insertSelective(@RequestBody CustomerPaymentChannelFee record);

	@PostMapping("/selectByPrimaryKey/{paymentChanneldFeeId}")
	ModelResult<CustomerPaymentChannelFee> selectByPrimaryKey(@PathVariable("paymentChanneldFeeId")Integer paymentChanneldFeeId);

	@PostMapping("/updateByPrimaryKeySelective")
    ModelResult<Integer> updateByPrimaryKeySelective(@RequestBody CustomerPaymentChannelFee record);

	@PostMapping("/updateByPrimaryKey")
    ModelResult<Integer> updateByPrimaryKey(@RequestBody CustomerPaymentChannelFee record);
	
	@PostMapping("/selectByCustomerIdAndPaymentChannelId/{customerId}/{paymentChannelId}")
	ModelResult<CustomerPaymentChannelFee> selectByCustomerIdAndPaymentChannelId(@PathVariable("customerId")Integer customerId,@PathVariable("paymentChannelId")Integer paymentChannelId);

}
