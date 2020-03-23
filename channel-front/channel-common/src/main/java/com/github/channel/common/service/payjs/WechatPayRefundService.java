package com.github.channel.common.service.payjs;

import com.github.appmodel.domain.result.ModelResult;
import com.github.channel.common.domain.ChannelRequest;
import com.github.channel.common.domain.ChannelResponse;

public interface WechatPayRefundService<R extends ChannelRequest,Q extends ChannelResponse> {
	
	public ModelResult<Q> refund(R request);

}
