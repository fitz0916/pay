package com.github.admin.client.service;

import java.util.List;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import com.github.admin.common.domain.Role;
import com.github.admin.common.vo.PageVo;
import com.github.appmodel.domain.result.ModelResult;
import com.github.appmodel.page.DataPage;

@FeignClient(name="admin-server")
@RequestMapping("/admin/server/role")
public interface RoleServiceClient {

	@GetMapping("/selectRoleByUserId/{userId}")
	ModelResult<List<Role>> selectRoleByUserId(@PathVariable("userId")Integer userId);

	@PostMapping("/pageRoleList")
	ModelResult<PageVo> pageRoleList(@RequestBody DataPage<Role> dataPage);

	@PostMapping("/allRolesList")
	ModelResult<List<Role>> allRolesList();

	@PostMapping("/insertSelective")
	ModelResult<Integer> insertSelective(@RequestBody Role role);

	@GetMapping("/selectByPrimaryKey/{roleId}")
	ModelResult<Role> selectByPrimaryKey(@PathVariable("roleId")Integer roleId);

	@PostMapping("/updateByPrimaryKeySelective")
	ModelResult<Integer> updateByPrimaryKeySelective(@RequestBody Role role);

	@GetMapping("/deleteByPrimaryKeys/{roleIds}")
	ModelResult<Integer> deleteByPrimaryKeys(@PathVariable("roleIds")String roleIds);
	
}
