package com.github.channel;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import com.github.appmodel.domain.result.ModelResult;
import com.github.channel.common.request.AliPayRequest;
import com.github.channel.common.response.AliPayResponse;
import com.github.channel.common.service.PayJsService;

@RunWith(SpringRunner.class)
@SpringBootTest(classes = Application.class)
public class AppTest {

	@Autowired
	private PayJsService<AliPayRequest,AliPayResponse> aliPayServiceImpl;
	
	@Test
	public void _测试支付接口() {
		AliPayRequest aliPayRequest = new AliPayRequest();
		aliPayRequest.setAttach("");
		aliPayRequest.setMchid("农家乐饭店");
		aliPayRequest.setBody("");
		aliPayRequest.setNotifyUrl("");
		aliPayRequest.setOutTradeNo("2020020112283");
		aliPayRequest.setTotalFee("1");
		aliPayRequest.setUrl("https://payjs.cn/api/native");
		aliPayRequest.setSecretKey("ZUa6Kw9Xe5B3B8en");
		
		ModelResult<AliPayResponse> modelResult = aliPayServiceImpl.pay(aliPayRequest);
		if(modelResult.isSuccess()) {
			AliPayResponse aliPayResponse = modelResult.getModel();
			System.out.println(aliPayResponse);
		}
		
	}
}
