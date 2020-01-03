package com.github.admin.client.service;

import java.util.List;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.github.admin.common.domain.Permission;
import com.github.appmodel.domain.result.ModelResult;

@FeignClient(name="admin-server")
@RequestMapping("/admin/server/permission")
public interface PermissionServiceClient {

	@GetMapping("/selectPermissionByUserId/{systemId}/{userId}")
	ModelResult<List<Permission>> selectPermissionByUserId(@PathVariable("systemId")Integer systemId, @PathVariable("userId")Integer userId);

}
