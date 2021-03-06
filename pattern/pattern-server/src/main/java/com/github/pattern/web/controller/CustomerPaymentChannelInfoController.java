package com.github.pattern.web.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.github.appmodel.domain.result.ModelResult;
import com.github.appmodel.vo.PageVo;
import com.github.pattern.common.domain.CustomerPaymentChannelInfo;
import com.github.pattern.common.request.CustomerPaymentChannelInfoRequest;
import com.github.pattern.common.service.CustomerPaymentChannelInfoService;

@RestController
@RequestMapping("/pattern/server/customerPaymentChannelInfo")
public class CustomerPaymentChannelInfoController {
	
	@Autowired
	private CustomerPaymentChannelInfoService customerPaymentChannelInfoImpl;
	
	
	@PostMapping("/page")
	public ModelResult<PageVo> page(@RequestBody CustomerPaymentChannelInfoRequest request){
		return customerPaymentChannelInfoImpl.page(request);
	}
	
	
	@PostMapping("/deleteByPrimaryKey/{customerPaymentChannelInfoId}")
	public ModelResult<Integer> deleteByPrimaryKey(@PathVariable("customerPaymentChannelInfoId")Integer customerPaymentChannelInfoId){
		return customerPaymentChannelInfoImpl.deleteByPrimaryKey(customerPaymentChannelInfoId);
	}

	@PostMapping("/insertSelective")
	public ModelResult<Integer> insertSelective(@RequestBody CustomerPaymentChannelInfo record){
		return customerPaymentChannelInfoImpl.insertSelective(record);
	}

	@PostMapping("/selectByPrimaryKey/{customerPaymentChannelInfoId}")
	public ModelResult<CustomerPaymentChannelInfo> selectByPrimaryKey(@PathVariable("customerPaymentChannelInfoId")Integer customerPaymentChannelInfoId){
		return customerPaymentChannelInfoImpl.selectByPrimaryKey(customerPaymentChannelInfoId);
	}

	@PostMapping("/updateByPrimaryKeySelective")
	public ModelResult<Integer> updateByPrimaryKeySelective(@RequestBody CustomerPaymentChannelInfo record){
		return customerPaymentChannelInfoImpl.updateByPrimaryKeySelective(record);
	}

    
    @PostMapping("/updateByPrimaryKey")
    public ModelResult<Integer> updateByPrimaryKey(@RequestBody CustomerPaymentChannelInfo record){
    	return customerPaymentChannelInfoImpl.updateByPrimaryKey(record);
    }

    @PostMapping("/paymentChannelInfoPage")
	ModelResult<PageVo> paymentChannelInfoPage(@RequestBody CustomerPaymentChannelInfoRequest request){
    	return customerPaymentChannelInfoImpl.paymentChannelInfoPage(request);
    }
    
    @PostMapping("/selectByCustomerIdAndPayType/{customerId}/{payType}")
	ModelResult<List<CustomerPaymentChannelInfo>> selectByCustomerIdAndPayType(@PathVariable("customerId")Integer customerId,@PathVariable("payType") String payType){
    	return customerPaymentChannelInfoImpl.selectByCustomerIdAndPayType(customerId,payType);
    }
}
