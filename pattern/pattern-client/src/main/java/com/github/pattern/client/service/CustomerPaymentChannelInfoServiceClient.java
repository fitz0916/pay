package com.github.pattern.client.service;

import java.util.List;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.github.appmodel.domain.result.ModelResult;
import com.github.appmodel.vo.PageVo;
import com.github.pattern.common.domain.CustomerPaymentChannelInfo;
import com.github.pattern.common.request.CustomerPaymentChannelInfoRequest;

@FeignClient(name="pattern-server")
@RequestMapping("/pattern/server/customerPaymentChannelInfo")
public interface CustomerPaymentChannelInfoServiceClient {
	
	
	@PostMapping("/page")
	ModelResult<PageVo> page(@RequestBody CustomerPaymentChannelInfoRequest request);
	
	
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

    @PostMapping("/paymentChannelInfoPage")
	ModelResult<PageVo> paymentChannelInfoPage(@RequestBody CustomerPaymentChannelInfoRequest request);

    @PostMapping("/selectByCustomerIdAndPayType/{customerId}/{payType}")
	ModelResult<List<CustomerPaymentChannelInfo>> selectByCustomerIdAndPayType(@PathVariable("customerId")Integer customerId,@PathVariable("payType") String payType);
    
    
    

}
