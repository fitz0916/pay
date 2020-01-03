package com.github.admin.client.service;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.alibaba.fastjson.JSONArray;
import com.github.appmodel.domain.result.ModelResult;

@FeignClient(name="admin-server")
@RequestMapping("/admin/server/userPermission")
public interface UserPermissionServiceClient {

	@PostMapping("/permission")
	ModelResult<Integer> permission(@RequestBody JSONArray datas, @RequestParam("userId")int userId);

}
