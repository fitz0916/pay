package com.github.pattern.web.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.github.appmodel.domain.result.ModelResult;
import com.github.appmodel.vo.ResultVo;
import com.github.pattern.common.domain.PaymentChannelInfoRisk;
import com.github.pattern.common.request.PaymentChannelInfoRiskRequest;
import com.github.pattern.common.service.PaymentChannelRiskInfoService;

@RestController
@RequestMapping("/pattern/server/paymentChannelRiskInfo")
public class PaymentChannelRiskInfoController {
	
	
	@Autowired
	private PaymentChannelRiskInfoService paymentChannelRiskInfoServiceImpl;
	
	@PostMapping("/page")
	public ModelResult<ResultVo> page(@RequestBody PaymentChannelInfoRiskRequest request){
		return paymentChannelRiskInfoServiceImpl.page(request);
	}
	
	@PostMapping("/deleteByPrimaryKey/{paymentChannelinfoRiskId}")
	public ModelResult<Integer> deleteByPrimaryKey(@PathVariable("paymentChannelinfoRiskId")Integer paymentChannelinfoRiskId){
		return paymentChannelRiskInfoServiceImpl.deleteByPrimaryKey(paymentChannelinfoRiskId);
	}

	@PostMapping("/insertSelective")
	public ModelResult<Integer> insertSelective(@RequestBody PaymentChannelInfoRisk record){
		return paymentChannelRiskInfoServiceImpl.insertSelective(record);
	}

	@PostMapping("/selectByPrimaryKey/{paymentChannelinfoRiskId}")
	public ModelResult<PaymentChannelInfoRisk> selectByPrimaryKey(@PathVariable("paymentChannelinfoRiskId")Integer paymentChannelinfoRiskId){
		return paymentChannelRiskInfoServiceImpl.selectByPrimaryKey(paymentChannelinfoRiskId);
	}

	@PostMapping("/updateByPrimaryKeySelective")
	public ModelResult<Integer> updateByPrimaryKeySelective(@RequestBody PaymentChannelInfoRisk record){
		return paymentChannelRiskInfoServiceImpl.updateByPrimaryKeySelective(record);
	}

	@PostMapping("/updateByPrimaryKey")
	public ModelResult<Integer> updateByPrimaryKey(@RequestBody PaymentChannelInfoRisk record){
		return paymentChannelRiskInfoServiceImpl.updateByPrimaryKey(record);
	}

}
