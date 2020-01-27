package com.github.trans.context;

import java.util.List;
import java.util.Map;
import java.util.Random;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.github.appmodel.domain.result.ModelResult;
import com.github.trans.common.service.ThirdChannelService;

@Component
public class ThirdChannelContext {
	
	@Autowired
	private Map<String,ThirdChannelService> thridChannelServiceMap;
	
	/***
	 * 支付类型，然后根据策略选择渠道
	 * @param payType
	 * @param strategy
	 * @return
	 */
	public ModelResult<ThirdChannelService> strategy(String templateName){
		ModelResult<ThirdChannelService> modelResult = new ModelResult<ThirdChannelService>();
		ThirdChannelService thirdChannelService  = thridChannelServiceMap.get(templateName);
		if(thirdChannelService == null) {
			modelResult.withError("0", "获取支付渠道接口失败");
			return modelResult;
		}
		modelResult.setModel(thirdChannelService);
		return modelResult;
	}

}
