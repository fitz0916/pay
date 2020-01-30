package com.github.channel.common.service;

import com.github.appmodel.domain.result.ModelResult;
import com.github.channel.common.domain.ChannelRequest;
import com.github.channel.common.domain.ChannelResponse;

public interface PayJsService<R extends ChannelRequest,Q extends ChannelResponse> {
	
	
	public ModelResult<Q> pay(R request);

}
