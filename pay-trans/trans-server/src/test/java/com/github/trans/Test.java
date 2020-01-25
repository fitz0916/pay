package com.github.trans;

import java.util.List;

import com.github.trans.common.request.PaymentRequest;
import com.github.trans.common.utils.BeanValidatorUtils;

public class Test {

	public static void main(String[] args) {
		PaymentRequest request = new PaymentRequest();
		List<String> list = BeanValidatorUtils.validateParam(request);
		System.out.println(list);

	}

}
