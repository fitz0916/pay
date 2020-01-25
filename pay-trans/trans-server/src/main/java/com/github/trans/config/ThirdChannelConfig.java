package com.github.trans.config;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Configurable;

import com.github.trans.common.service.ThirdChannelService;

@Configurable
public class ThirdChannelConfig {

	@Resource
	private ThirdChannelService aliPayServiceImpl;
	
	@Resource
	private ThirdChannelService wechatPayServiceImpl;
	
	
	public Map<String,List<ThirdChannelService>> thridChannelServiceMap(){
		Map<String,List<ThirdChannelService>> map = new HashMap<String,List<ThirdChannelService>>();
		wechatPayChannelMap(map);
		aliPayChannelMap(map);
		return map;
	}
	
	/***
	 * 微信扫码，如果后期接入多个渠道支持微信扫码接口，全部放入集合里，然后根据算法：随机、权重等算法来获取渠道
	 * @param map
	 */
	private void wechatPayChannelMap(Map<String,List<ThirdChannelService>> map) {
		List<ThirdChannelService> list = new ArrayList<ThirdChannelService>();
		list.add(wechatPayServiceImpl);
		map.put("1", list);
	}
	
	private void aliPayChannelMap(Map<String,List<ThirdChannelService>> map) {
		List<ThirdChannelService> list = new ArrayList<ThirdChannelService>();
		list.add(aliPayServiceImpl);
		map.put("2", list);
	}
	
}
