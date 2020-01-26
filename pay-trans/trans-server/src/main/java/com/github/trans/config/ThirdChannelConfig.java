package com.github.trans.config;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Configurable;
import org.springframework.context.annotation.Bean;

import com.github.trans.common.service.ThirdChannelService;

@Configurable
public class ThirdChannelConfig {

	@Resource
	private ThirdChannelService aliPayServiceImpl;
	
	@Resource
	private ThirdChannelService wechatPayServiceImpl;
	
	@Bean
	public Map<String,ThirdChannelService> thridChannelServiceMap(){
		Map<String,ThirdChannelService> map = new HashMap<String,ThirdChannelService>();
		map.put(aliPayServiceImpl.getClass().getSimpleName(), aliPayServiceImpl);
		map.put(wechatPayServiceImpl.getClass().getSimpleName(), wechatPayServiceImpl);
		return map;
	}
	
}
