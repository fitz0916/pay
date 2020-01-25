package com.github.trans.context;

import java.util.List;
import java.util.Map;
import java.util.Random;

import org.apache.commons.collections.CollectionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.github.appmodel.domain.result.ModelResult;
import com.github.trans.common.request.TransRequest;
import com.github.trans.common.response.TransResponse;
import com.github.trans.common.service.ThirdChannelService;

@Component
public class ThirdChannelContext {
	
	@Autowired
	private Map<String,List<ThirdChannelService>> thridChannelServiceMap;
	
	/***
	 * 支付类型，然后根据策略选择渠道
	 * @param payType
	 * @param strategy
	 * @return
	 */
	public ModelResult<ThirdChannelService> strategy(String payType,String strategy){
		ModelResult<ThirdChannelService> modelResult = new ModelResult<ThirdChannelService>();
		List<ThirdChannelService> list = thridChannelServiceMap.get(payType);
		if(CollectionUtils.isNotEmpty(list)) {
			//为0则随机
			if(strategy.equals("0")) {
				int size = list.size() - 1;
				Random random = new Random();
				int index = random.nextInt(size);
				ThirdChannelService thirdChannelService = list.get(index);
				if(thirdChannelService == null) {
					modelResult.withError("0", "获取支付渠道接口失败");
					return modelResult;
				}
				modelResult.setModel(thirdChannelService);
				return modelResult;
			}
		}
		modelResult.withError("0", "获取支付渠道接口失败");
		return modelResult;
	}

}
