package com.github.channel.common.utils;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Set;

import org.apache.commons.codec.digest.DigestUtils;

import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.PropertyNamingStrategy;
import com.alibaba.fastjson.serializer.SerializeConfig;

public class PayJsSignUtils {

	/**
     * 获取签名
     * @param object 需要签名的数据
     * @param key 签名用到的key
     * @return 数据签名
     */
    public static String getSign(Object object, String key) {

        SerializeConfig config = new SerializeConfig();
        config.propertyNamingStrategy = PropertyNamingStrategy.SnakeCase;
        String jsonString = JSONObject.toJSONString(object, config);
        JSONObject jsonObject = JSONObject.parseObject(jsonString);

        // 排序
        Set<String> keys = jsonObject.keySet();
        List<String> keysList = new ArrayList<>(keys.size());
        keys.forEach(item -> keysList.add(item));
        Collections.sort(keysList);

        StringBuilder stringBuilder = new StringBuilder();
        keysList.forEach(item -> {
                stringBuilder.append(item + "=" + jsonObject.get(item) + "&");
        });
        stringBuilder.append("key=" + key);

        return DigestUtils.md5Hex(stringBuilder.toString()).toUpperCase();
    }
}
