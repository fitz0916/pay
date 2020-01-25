package com.github.trans.common.utils;

import java.util.Base64;
import java.util.Map;

import com.github.trans.common.exception.PaymentException;
import com.github.trans.common.request.PaymentRequest;

/**
 * 签名工具类
 *
 */
public class PaySignUtil {

	/**
	 * 参数签名
	 * @param signObj 需要签名实体类
	 * @param agentSecretKey 商户密钥
	 * @param ignoreProperties  忽略的属性
	 * @return 参数值
	 */
	public static String requestMd5Sign(Object signObj, String agentSecretKey, String... ignoreProperties) throws PaymentException {
//		VerifyParamtersUtils.verifyParameters(signObj); // 验证参与签名的参数
		Map<String, Object> map = VerifyParamtersUtils.toEncryptionMap(signObj, false, false, ignoreProperties); // 参数排序
		String sortPostParam = VerifyParamtersUtils.mapToPostUrl(map); // 获取排序后的post参数
		sortPostParam += agentSecretKey; // 参数拼装商户密钥进行签名
		String signAture = Base64.getEncoder().encodeToString(MD5Encrypt.sign(sortPostParam).getBytes());
		return signAture;
	}

	public static void main(String[] args) {
		testPaymentRequestMd5Sign();
	}

	/**
	 * 支付请求签名验证签名
	 */
	private static void testPaymentRequestMd5Sign() {
		PaymentRequest paymentRequest = new PaymentRequest();
//		paymentRequest.setSignature("MzFlMjY1YjA3ZWNjN2E1ZGEwNDNmYTVhNTcyZTAxNDc="); // 签名 不参与签名
//		paymentRequest.setSignMethod("MD5"); // 签名方式 不参与生成签名
//
//		paymentRequest.setAmount("900");// 金额 分
//		paymentRequest.setBankCode("100001");// 只有为网银支付的时候才能有,其他支付,一定不能有
//		paymentRequest.setCurrency("CNY");// 货币类型,目前只有CNY
//		paymentRequest.setDescribe("cGF5"); // 支付备注
//		paymentRequest.setMerId(2341l); // 商户ID
//		paymentRequest.setMerOrderId("2018051714083955985057"); // 商户订单ID 不能重复
//		paymentRequest.setMerUserId("113.89.236.237"); // 商户userID可空
//		paymentRequest.setPayMode("0201"); // 0701-扫码支付，0201-web支付
//		paymentRequest.setRemark("cGF5");// 备注,支付备注
//		paymentRequest.setSubject("cGF5"); //
//		paymentRequest.setTradeSubtype("01"); // 01常规
//		paymentRequest.setTradeTime("20180517140856"); // 交易时间yyyyMMddHHiiss
//		paymentRequest.setTradeType("52");
//		paymentRequest.setUrlBack("*");
//		paymentRequest.setUrlJump("http://47.95.234.243/api/OpayCallBack.php");
//		paymentRequest.setUserIP("113.89.236.237");
//		paymentRequest.setVersion("1.0.0");
//		paymentRequest.base64Decoder(); // 签名前需要将参数进行解码,否则验签会失败
		String sign;
		if (paymentRequest.getTradeType().equals("52")) {
			sign = requestMd5Sign(paymentRequest, "SCAfOqBTFpqLzJ4W2gVB");
		} else {
			sign = requestMd5Sign(paymentRequest, "SCAfOqBTFpqLzJ4W2gVB", "bankCode"); // 非银行卡支付bankCode不参与签名
		}
	}
}
