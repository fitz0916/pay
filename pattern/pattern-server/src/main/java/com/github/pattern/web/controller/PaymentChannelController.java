package com.github.pattern.web.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.github.appmodel.domain.result.ModelResult;
import com.github.pattern.common.domain.PaymentChannel;
import com.github.pattern.common.request.PaymentChannelRequest;
import com.github.pattern.common.service.PaymentChannelService;
import com.github.pattern.common.vo.ResultVo;

@RestController
@RequestMapping("/pattern/server/paymentChannel")
public class PaymentChannelController {
	
		@Autowired
		private PaymentChannelService paymentChannelServiceImpl;
	

		@PostMapping("/page")
		public ModelResult<ResultVo> page(@RequestBody PaymentChannelRequest request){
			return paymentChannelServiceImpl.page(request);
		}
	
		@PostMapping("/deleteByPrimaryKey/{payChannelId}")
		public ModelResult<Integer> deleteByPrimaryKey(@PathVariable("paymentTypeId")Integer payChannelId){
			return paymentChannelServiceImpl.deleteByPrimaryKey(payChannelId);
		}

		@PostMapping("/insertSelective")
		public ModelResult<Integer> insertSelective(@RequestBody PaymentChannel record){
			return paymentChannelServiceImpl.insertSelective(record);
		}

		@PostMapping("/selectByPrimaryKey/{payChannelId}")
		public ModelResult<PaymentChannel> selectByPrimaryKey(@PathVariable("paymentTypeId")Integer payChannelId){
			return paymentChannelServiceImpl.selectByPrimaryKey(payChannelId);
		}

		@PostMapping("/updateByPrimaryKeySelective")
		public ModelResult<Integer> updateByPrimaryKeySelective(@RequestBody PaymentChannel record){
			return paymentChannelServiceImpl.updateByPrimaryKeySelective(record);
		}

		@PostMapping("/updateByPrimaryKey")
		public ModelResult<Integer> updateByPrimaryKey(@RequestBody PaymentChannel record){
			return paymentChannelServiceImpl.updateByPrimaryKey(record);
		}
}
