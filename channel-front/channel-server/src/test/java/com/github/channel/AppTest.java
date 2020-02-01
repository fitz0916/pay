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
		wechatPayRequest.setAttach("test");
		wechatPayRequest.setMchid("1575132401");
		wechatPayRequest.setBody("tedt");
		wechatPayRequest.setOutTradeNo("202002011228311800");
		wechatPayRequest.setTotalFee("10");
		wechatPayRequest.setUrl("https://payjs.cn/api/native");
		wechatPayRequest.setSecretKey("ZUa6Kw9Xe5B3B8en");
		wechatPayRequest.setNotifyUrl("https://www.baidu.com/");
		ModelResult<WechatPayResponse> modelResult = wechatPayServiceImpl.pay(wechatPayRequest);
		if(modelResult.isSuccess()) {
			WechatPayResponse wechatPayResponse = modelResult.getModel();
			System.out.println(wechatPayResponse.toString());
		}else {
			String errorCode = modelResult.getErrorCode();
			String errorMsg = modelResult.getErrorMsg();
			System.out.println("errorCode = " + errorCode + "********,errorMsg = " + errorMsg );
		}
		
	}
}
