package com.github.channel.common.domain;

import java.io.Serializable;

import org.apache.commons.lang3.builder.ReflectionToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

public abstract class BaseObject implements Serializable{

	@Override
	public String toString() {
		return ReflectionToStringBuilder.toString(this,ToStringStyle.MULTI_LINE_STYLE);
	}
}
