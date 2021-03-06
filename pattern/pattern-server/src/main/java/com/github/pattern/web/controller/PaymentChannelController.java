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
import com.github.pattern.common.domain.PaymentChannel;
import com.github.pattern.common.request.PaymentChannelRequest;
import com.github.pattern.common.service.PaymentChannelService;

@RestController
@RequestMapping("/pattern/server/paymentChannel")
public class PaymentChannelController {
	
		@Autowired
		private PaymentChannelService paymentChannelServiceImpl;
	

		@PostMapping("/page")
		public ModelResult<PageVo> page(@RequestBody PaymentChannelRequest request){
			return paymentChannelServiceImpl.page(request);
		}
	
		@PostMapping("/deleteByPrimaryKey/{paymentChannelId}")
		public ModelResult<Integer> deleteByPrimaryKey(@PathVariable("paymentChannelId")Integer paymentChannelId){
			return paymentChannelServiceImpl.deleteByPrimaryKey(paymentChannelId);
		}

		@PostMapping("/insertSelective")
		public ModelResult<Integer> insertSelective(@RequestBody PaymentChannel record){
			return paymentChannelServiceImpl.insertSelective(record);
		}

		@PostMapping("/selectByPrimaryKey/{paymentChannelId}")
		public ModelResult<PaymentChannel> selectByPrimaryKey(@PathVariable("paymentChannelId")Integer paymentChannelId){
			return paymentChannelServiceImpl.selectByPrimaryKey(paymentChannelId);
		}

		@PostMapping("/updateByPrimaryKeySelective")
		public ModelResult<Integer> updateByPrimaryKeySelective(@RequestBody PaymentChannel record){
			return paymentChannelServiceImpl.updateByPrimaryKeySelective(record);
		}

		@PostMapping("/updateByPrimaryKey")
		public ModelResult<Integer> updateByPrimaryKey(@RequestBody PaymentChannel record){
			return paymentChannelServiceImpl.updateByPrimaryKey(record);
		}
		
		@PostMapping("/list")
	    ModelResult<List<PaymentChannel>> list(){
			return paymentChannelServiceImpl.list();
		}
}
