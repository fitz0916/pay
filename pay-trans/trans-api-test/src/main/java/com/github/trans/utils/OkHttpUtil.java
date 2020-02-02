package com.github.trans.utils;


import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.TimeUnit;

import org.apache.http.protocol.HTTP;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.alibaba.fastjson.JSONObject;
import com.github.trans.exception.PaymentException;

import okhttp3.Call;
import okhttp3.Callback;
import okhttp3.FormBody;
import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;
import okhttp3.Response;


public class OkHttpUtil {

    private static Logger logger = LoggerFactory.getLogger(OkHttpUtil.class);

    public static final int TYPE_GET = 0; //GET请求
    public static final int TYPE_POST_JSON = 1;// POST json方式
    public static final int TYPE_POST_FORM = 2;// POST form表单
    public static final MediaType MEDIA_TYPE_FORM = MediaType.parse("application/x-www-form-urlencoded; charset=utf-8");
    public static final MediaType MEDIA_TYPE_JSON = MediaType.parse("application/json; charset=utf-8");
    public static final MediaType MEDIA_TYPE_XML = MediaType.parse("text/xml;charset=UTF-8");
    //超时时间
    public static final int TIMEOUT= 1000 * 60;
    
    private static OkHttpClient okHttpClient;
    private Request.Builder requestBuilder;
    private static OkHttpUtil instance;

    private OkHttpUtil(){
    	okHttpClient = new OkHttpClient.Builder()
                .writeTimeout(3000, TimeUnit.SECONDS)
                .readTimeout(3000, TimeUnit.SECONDS)
                .build();
        requestBuilder = new Request.Builder();
    }

    public static synchronized OkHttpUtil getInstance(){
    	if(instance == null) {
    		instance = new OkHttpUtil();
    	}
        return instance;
    }

    /**
     * 同步请求
     * @param request
     * @return
     * @throws IOException
     */
    public  Response execute(Request request) throws IOException {
        return okHttpClient.newCall(request).execute();
    }


    /**
     * 同步get请求
     * @param url
     * @param paramsMap
     * @return
     * @throws IOException
     */
    public String get(String url, HashMap<String,String> paramsMap) throws IOException {
        StringBuilder params = parseParams(paramsMap);
        String requestUrl = String.format("%s?%s", url, params);
        logger.info("请求URL：{}",requestUrl);
        Request request = new Request.Builder().url(requestUrl).build();
        Response response = execute(request);
        if (response.isSuccessful()) {
            return response.body().string();
        } else {
            logger.info("【请求失败】");
            throw new PaymentException("59041","请求失败");
        }
    }
    
    /**
     * 同步get请求
     * @param url
     * @param
     * @return
     * @throws IOException
     */
    public String get(String url) throws IOException {
        Request request = new Request.Builder().url(url).build();
        Response response = execute(request);
        if (response.isSuccessful()) {
            return response.body().string();
        } else {
            logger.info("【请求失败】");
            throw new PaymentException("59041","请求失败");
        }
    }

    /**
     * 同步post form表单
     * @param url
     * @param paramsMap
     * @return
     * @throws IOException
     */
    public String postWithForm(String url, Map<String,String> paramsMap) throws IOException {
        FormBody.Builder builder = new FormBody.Builder();
        for (String key : paramsMap.keySet()) {
            builder.add(key, paramsMap.get(key));
        }
        RequestBody formBody = builder.build();
        logger.info("formBody:{}",formBody);
        Request request = new Request.Builder().url(url).post(formBody).build();
        Response response = execute(request);
        //Warning!!!不要多次调用这个方法，会异常response.body().string()；
        if (response.isSuccessful()) {
            String res = response.body().string();
            logger.info("【HttpClient返回】{}",res);
            return res;
        } else {
            logger.info("【请求失败】");
            throw new PaymentException("59041","请求失败");
        }
    }

    /**
     * 同步post json
     * @param url
     * @param jsonObject
     * @return
     * @throws IOException
     */
    public String postWithJson(String url, JSONObject jsonObject) throws IOException {
        RequestBody requestBody = RequestBody.create(MEDIA_TYPE_JSON, jsonObject.toJSONString());
        logger.info("requestBody:{}",requestBody);
        Request request = new Request.Builder().header(HTTP.CONTENT_TYPE,"application/json").url(url).post(requestBody).build();
        Response response = execute(request);
        if (response.isSuccessful()) {
            //Warning!!!不要多次调用这个方法，会异常response.body().string()；
            return response.body().string();
        } else {
            logger.info("【请求失败】");
            throw new PaymentException("59041","请求失败");
        }
    }

    /**
     *
     * @param url
     * @param xmlStr
     * @return
     * @throws IOException
     */
    public String postWithXml(String url,String xmlStr) throws IOException{
        RequestBody requestBody = RequestBody.create(MEDIA_TYPE_XML, xmlStr);
        Request request = new Request.Builder().url(url).post(requestBody).build();
        Response  response = execute(request);
        if (response.isSuccessful()) {
            //Warning!!!不要多次调用这个方法，会异常response.body().string()；
            return response.body().string();
        } else {
            logger.info("【请求失败】");
            throw new PaymentException("59041","请求失败");
        }
    }

    /**
     * 格式化参数
     * @param paramsMap
     * @return
     * @throws UnsupportedEncodingException
     */
    private StringBuilder parseParams(HashMap<String, String> paramsMap) throws UnsupportedEncodingException {
        StringBuilder params = new StringBuilder();
        int pos = 0;
        for (String key : paramsMap.keySet()) {
            if (pos > 0) {
                params.append("&");
            }
            params.append(String.format("%s=%s", key, URLEncoder.encode(paramsMap.get(key), "utf-8")));
            pos++;
        }
        return params;
    }

    /**
     * 异步请求
     * @param request
     */
    public void enqueue(Request request){
        okHttpClient.newCall(request).enqueue(new ResponseCallback());
    }

    private class ResponseCallback implements Callback{
        @Override
        public void onFailure(Call call, IOException e) {
            logger.info("请求失败");
        }

        @Override
        public void onResponse(Call call, Response response){
            try {
                logger.info("响应信息为：{}",response.body().string());

            } catch (IOException e) {
                logger.error("异步回调异常：{}",e.getMessage());
            }
        }

    }
    
    //TODO
    private void getAsync(String url, HashMap<String, String> paramsMap) throws IOException {
        StringBuilder params = parseParams(paramsMap);
        String requestUrl = String.format("%s?%s", url, params.toString());
        logger.info("请求URL：{}",requestUrl);
        Request request = new Request.Builder().url(requestUrl).build();
        enqueue(request);
    }
    //TODO
    private void postAsyncWithForm(String url, HashMap<String, String> paramsMap) throws IOException {
        FormBody.Builder builder = new FormBody.Builder();
        for (String key : paramsMap.keySet()) {
            builder.add(key, paramsMap.get(key));
        }
        RequestBody formBody = builder.build();
        logger.info("formBody:{}",formBody);
        Request request = new Request.Builder().url(url).post(formBody).build();
        enqueue(request);
    }
    //TODO
    private void postAsyncWithJson(String url, HashMap<String, String> paramsMap) throws IOException {
        String params = parseParams(paramsMap).toString();
        RequestBody requestBody = RequestBody.create(MEDIA_TYPE_JSON, params);
        logger.info("requestBody:{}",requestBody);
        Request request = new Request.Builder().url(url).post(requestBody).build();
        enqueue(request);
    }

}
