package com.github.pattern.web.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.github.appmodel.domain.result.ModelResult;
import com.github.pattern.common.domain.PaymentBlackList;
import com.github.pattern.common.request.PaymentBlackListRequest;
import com.github.pattern.common.service.PaymentBlackListService;
import com.github.pattern.common.vo.PageVo;

@RestController
@RequestMapping("/pattern/server/paymentBlackList")
public class PaymentBlackListController {
	
	
	@Autowired
	private PaymentBlackListService paymentBlackListServiceImpl;
	
	@PostMapping("/page")
	public ModelResult<PageVo> page(@RequestBody PaymentBlackListRequest request){
		return paymentBlackListServiceImpl.page(request);
	}
	
	@PostMapping("/deleteByPrimaryKey/{paymentBlackListId}")
	public ModelResult<Integer> deleteByPrimaryKey(@PathVariable("paymentBlackListId")Integer paymentBlackListId){
		return paymentBlackListServiceImpl.deleteByPrimaryKey(paymentBlackListId);
	}

	@PostMapping("/insertSelective")
	public ModelResult<Integer> insertSelective(@RequestBody PaymentBlackList record){
		return paymentBlackListServiceImpl.insertSelective(record);
	}

	@PostMapping("/selectByPrimaryKey/{paymentBlackListId}")
	public ModelResult<PaymentBlackList> selectByPrimaryKey(@PathVariable("paymentBlackListId")Integer paymentBlackListId){
		return paymentBlackListServiceImpl.selectByPrimaryKey(paymentBlackListId);
	}
	
	@PostMapping("/updateByPrimaryKeySelective")
	public ModelResult<Integer> updateByPrimaryKeySelective(@RequestBody PaymentBlackList record){
		return paymentBlackListServiceImpl.updateByPrimaryKeySelective(record);
	}

	@PostMapping("/updateByPrimaryKey")
	public ModelResult<Integer> updateByPrimaryKey(@RequestBody PaymentBlackList record){
		return paymentBlackListServiceImpl.updateByPrimaryKey(record);
	}

}
