package com.github.admin.common.service;

import com.alibaba.fastjson.JSONArray;
import com.github.appmodel.domain.result.ModelResult;

public interface UserPermissionService {

	ModelResult<Integer> permission(JSONArray datas, Integer userId);

}
