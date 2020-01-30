package com.github.channel;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import com.github.appmodel.domain.result.ModelResult;
import com.github.channel.common.request.AliPayRequest;
import com.github.channel.common.request.WechatPayRequest;
import com.github.channel.common.response.AliPayResponse;
import com.github.channel.common.response.WechatPayResponse;
import com.github.channel.common.service.PayJsService;

@RunWith(SpringRunner.class)
@SpringBootTest(classes = Application.class)
public class AppTest {

	@Autowired
	private PayJsService<WechatPayRequest,WechatPayResponse> wechatPayServiceImpl;
	
	@Test
	public void _测试支付接口() {
		WechatPayRequest wechatPayRequest = new WechatPayRequest();
		wechatPayRequest.setAttach("");
		wechatPayRequest.setMchid("农家乐饭店");
		wechatPayRequest.setBody("");
		wechatPayRequest.setNotifyUrl("");
		wechatPayRequest.setOutTradeNo("2020020112283");
		wechatPayRequest.setTotalFee("1");
		wechatPayRequest.setUrl("https://payjs.cn/api/native");
		wechatPayRequest.setSecretKey("ZUa6Kw9Xe5B3B8en");
		
		ModelResult<WechatPayResponse> modelResult = wechatPayServiceImpl.pay(wechatPayRequest);
		if(modelResult.isSuccess()) {
			WechatPayResponse wechatPayResponse = modelResult.getModel();
			System.out.println(wechatPayResponse);
		}
		
	}
}
