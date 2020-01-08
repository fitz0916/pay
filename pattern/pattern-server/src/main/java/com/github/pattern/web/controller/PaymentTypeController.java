package com.github.pattern.web.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.github.appmodel.domain.result.ModelResult;
import com.github.pattern.common.domain.PaymentType;
import com.github.pattern.common.request.PaymentTypeRequest;
import com.github.pattern.common.service.PaymentTypeService;
import com.github.pattern.common.vo.ResultVo;

@RestController
@RequestMapping("/pattern/server/paymentType")
public class PaymentTypeController {

	
	@Autowired
	private PaymentTypeService paymentTypeServiceImpl;
	
	@PostMapping("/page")
	public ModelResult<ResultVo> page(@RequestBody PaymentTypeRequest request){
		return paymentTypeServiceImpl.page(request);
	}
	
	@PostMapping("/deleteByPrimaryKey/{paymentTypeId}")
	public ModelResult<Integer> deleteByPrimaryKey(@PathVariable("paymentTypeId")Integer paymentTypeId){
		return paymentTypeServiceImpl.deleteByPrimaryKey(paymentTypeId);
	}

	@PostMapping("/insert")
	public ModelResult<Integer> insert(@RequestBody PaymentType record){
		return paymentTypeServiceImpl.insert(record);
	}

	@PostMapping("/insertSelective")
	public ModelResult<Integer> insertSelective(@RequestBody PaymentType record){
		return paymentTypeServiceImpl.insertSelective(record);
	}

	@PostMapping("/selectByPrimaryKey/{paymentTypeId}")
	public ModelResult<PaymentType> selectByPrimaryKey(@PathVariable("paymentTypeId")Integer paymentTypeId){
		 return paymentTypeServiceImpl.selectByPrimaryKey(paymentTypeId);
	}

	@PostMapping("/updateByPrimaryKeySelective")
	public ModelResult<Integer> updateByPrimaryKeySelective(@RequestBody PaymentType record){
		 return paymentTypeServiceImpl.updateByPrimaryKeySelective(record);
	}

	@PostMapping("/updateByPrimaryKey")
	public ModelResult<Integer> updateByPrimaryKey(@RequestBody PaymentType record){
		return paymentTypeServiceImpl.updateByPrimaryKey(record);
	}
}
