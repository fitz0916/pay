package com.github.pattern.web.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.github.appmodel.domain.result.ModelResult;
import com.github.pattern.common.domain.PaymentWhiteList;
import com.github.pattern.common.request.PaymentWhiteListRequest;
import com.github.pattern.common.service.PaymentWhiteListService;
import com.github.pattern.common.vo.ResultVo;


@RestController
@RequestMapping("/pattern/server/paymentWhiteList")
public class PaymentWhiteListController {

	@Autowired
	private PaymentWhiteListService paymentWhiteListServiceImpl;;
	
	@PostMapping("/page")
	public ModelResult<ResultVo> page(@RequestBody PaymentWhiteListRequest request){
		return paymentWhiteListServiceImpl.page(request);
	}
	
	@PostMapping("/deleteByPrimaryKey/{paymentWhiteListId}")
	public ModelResult<Integer> deleteByPrimaryKey(@PathVariable("paymentWhiteListId")Integer paymentWhiteListId){
		return paymentWhiteListServiceImpl.deleteByPrimaryKey(paymentWhiteListId);
	}

	@PostMapping("/insert")
	public ModelResult<Integer> insert(@RequestBody PaymentWhiteList record){
		return paymentWhiteListServiceImpl.insert(record);
	}

	@PostMapping("/insertSelective")
	public ModelResult<Integer> insertSelective(@RequestBody PaymentWhiteList record){
		return paymentWhiteListServiceImpl.insertSelective(record);
	}

	@PostMapping("/selectByPrimaryKey/{paymentWhiteListId}")
	public ModelResult<PaymentWhiteList> selectByPrimaryKey(@PathVariable Integer paymentWhiteListId){
		return paymentWhiteListServiceImpl.selectByPrimaryKey(paymentWhiteListId);
	}

	@PostMapping("/updateByPrimaryKeySelective")
	public ModelResult<Integer> updateByPrimaryKeySelective(@RequestBody PaymentWhiteList record){
		return paymentWhiteListServiceImpl.updateByPrimaryKeySelective(record);
	}

	@PostMapping("/updateByPrimaryKey")
	public ModelResult<Integer> updateByPrimaryKey(@RequestBody PaymentWhiteList record){
		return paymentWhiteListServiceImpl.updateByPrimaryKey(record);
	}
}
