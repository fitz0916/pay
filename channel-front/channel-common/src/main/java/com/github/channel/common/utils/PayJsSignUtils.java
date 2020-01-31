package com.github.channel.common.utils;

import java.util.Map;

import org.apache.commons.codec.digest.DigestUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class PayJsSignUtils {

	private final static Logger LOGGER = LoggerFactory.getLogger(PayJsSignUtils.class);
	
	/**
     * 获取签名
     * @param object 需要签名的数据
     * @param key 签名用到的key
     * @return 数据签名
     */
    public static String getSign(Object object, String key,String ...ignoreProperties) {

//        SerializeConfig config = new SerializeConfig();
//        config.propertyNamingStrategy = PropertyNamingStrategy.SnakeCase;
//        String jsonString = JSONObject.toJSONString(object, config);
//        JSONObject jsonObject = JSONObject.parseObject(jsonString);
//
//        // 排序
//        Set<String> keys = jsonObject.keySet();
//        List<String> keysList = new ArrayList<>(keys.size());
//        keys.forEach(item -> keysList.add(item));
//        Collections.sort(keysList);
//
//        StringBuilder stringBuilder = new StringBuilder();
//        keysList.forEach(item -> {
//                stringBuilder.append(item + "=" + jsonObject.get(item) + "&");
//        });
//        stringBuilder.append("key=" + key);
    	Map<String, Object> map = VerifyParamtersUtils.toEncryptionMap(object, false, false, ignoreProperties); // 参数排序
		String sortPostParam = VerifyParamtersUtils.mapToPostUrl(map); // 获取排序后的post参数
		sortPostParam += "&key=" + key; // 参数拼装商户密钥进行签名
        LOGGER.info("签名结果:result = 【{}】",sortPostParam);
        String sign = DigestUtils.md5Hex(sortPostParam).toUpperCase();
        LOGGER.info("验签结果sign = 【{}】",sign);
        return sign;
    }
}
