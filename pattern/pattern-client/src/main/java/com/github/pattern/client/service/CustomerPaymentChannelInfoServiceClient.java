package com.github.pattern.client.service;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.github.appmodel.domain.result.ModelResult;
import com.github.pattern.common.domain.CustomerPaymentChannelInfo;
import com.github.pattern.common.request.CustomerPaymentChannelInfoRequest;
import com.github.pattern.common.vo.ResultVo;

@FeignClient(name="pattern-server")
@RequestMapping("/pattern/server/customerPaymentChannelInfo")
public interface CustomerPaymentChannelInfoServiceClient {
	
	
	@PostMapping("/page")
	ModelResult<ResultVo> page(@RequestBody CustomerPaymentChannelInfoRequest request);
	
	
	@PostMapping("/deleteByPrimaryKey/{customerPaymentChannelInfoId}")
	ModelResult<Integer> deleteByPrimaryKey(@PathVariable("customerPaymentChannelInfoId")Integer customerPaymentChannelInfoId);

	@PostMapping("/insertSelective")
	ModelResult<Integer> insertSelective(@RequestBody CustomerPaymentChannelInfo record);

	@PostMapping("/selectByPrimaryKey/{customerPaymentChannelInfoId}")
	ModelResult<CustomerPaymentChannelInfo> selectByPrimaryKey(@PathVariable("customerPaymentChannelInfoId")Integer customerPaymentChannelInfoId);

	@PostMapping("/updateByPrimaryKeySelective")
    ModelResult<Integer> updateByPrimaryKeySelective(@RequestBody CustomerPaymentChannelInfo record);

    
    @PostMapping("/updateByPrimaryKey")
    ModelResult<Integer> updateByPrimaryKey(@RequestBody CustomerPaymentChannelInfo record);

}
