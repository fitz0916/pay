package com.github.pattern.web.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.github.appmodel.domain.result.ModelResult;
import com.github.pattern.common.domain.PaymentChannelAccountPara;
import com.github.pattern.common.request.PaymentChannelAccountParaRequest;
import com.github.pattern.common.service.PaymentChannelAccountParaService;
import com.github.pattern.common.vo.ResultVo;

@RestController
@RequestMapping("/pattern/server/paymentChannelAccountPara")
public class PaymentChannelAccountParaController {
	
	
	@Autowired
	private PaymentChannelAccountParaService paymentChannelAccountParaServiceImpl;
	
	@PostMapping("/page")
	public ModelResult<ResultVo> page(@RequestBody PaymentChannelAccountParaRequest request){
		return paymentChannelAccountParaServiceImpl.page(request);
	}
	
	@PostMapping("/deleteByPrimaryKey/{PaymentChannelAccountParaId}")
	public ModelResult<Integer> deleteByPrimaryKey(@PathVariable("PaymentChannelAccountParaId")Integer PaymentChannelAccountParaId){
		return paymentChannelAccountParaServiceImpl.deleteByPrimaryKey(PaymentChannelAccountParaId);
	}

	@PostMapping("/insert")
	public ModelResult<Integer> insert(@RequestBody PaymentChannelAccountPara record){
		return paymentChannelAccountParaServiceImpl.insert(record);
	}

	@PostMapping("/insertSelective")
	public ModelResult<Integer> insertSelective(@RequestBody PaymentChannelAccountPara record){
		return paymentChannelAccountParaServiceImpl.insertSelective(record);
	}

	@PostMapping("/selectByPrimaryKey/{PaymentChannelAccountParaId}")
	public ModelResult<PaymentChannelAccountPara> selectByPrimaryKey(@PathVariable("PaymentChannelAccountParaId")Integer PaymentChannelAccountParaId){
		return paymentChannelAccountParaServiceImpl.selectByPrimaryKey(PaymentChannelAccountParaId);
	}

	@PostMapping("/updateByPrimaryKeySelective")
	public ModelResult<Integer> updateByPrimaryKeySelective(@RequestBody PaymentChannelAccountPara record){
		return paymentChannelAccountParaServiceImpl.updateByPrimaryKeySelective(record);
	}

	@PostMapping("/updateByPrimaryKey")
	public ModelResult<Integer> updateByPrimaryKey(@RequestBody PaymentChannelAccountPara record){
		return paymentChannelAccountParaServiceImpl.updateByPrimaryKey(record);
	}

}
