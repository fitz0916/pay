package com.github.trans.server.service;

import org.springframework.stereotype.Service;

import com.github.appmodel.domain.result.ModelResult;
import com.github.pattern.common.domain.Customer;
import com.github.trans.common.request.PaymentRequest;
import com.github.trans.common.response.PaymentResponse;
import com.github.trans.common.service.ThirdChannelService;

@Service
public class WechatPayServiceImpl implements ThirdChannelService{

	@Override
	public ModelResult<PaymentResponse> process(PaymentRequest request, Customer customer) {
		// TODO Auto-generated method stub
		return null;
	}

	

}
