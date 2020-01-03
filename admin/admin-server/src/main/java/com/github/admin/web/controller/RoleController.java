package com.github.admin.web.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.github.admin.common.domain.Role;
import com.github.admin.common.service.RoleService;
import com.github.admin.common.vo.PageVo;
import com.github.appmodel.domain.result.ModelResult;
import com.github.appmodel.page.DataPage;



@RestController
@RequestMapping("/admin/server/role")
public class RoleController {

	@Autowired
	private RoleService roleServiceImpl;
	
	@GetMapping("/selectRoleByUserId/{userId}")
	ModelResult<List<Role>> selectRoleByUserId(@PathVariable("userId")Integer userId){
		return roleServiceImpl.selectRoleByUserId(userId);
	}
	@PostMapping("/pageRoleList")
	ModelResult<PageVo> pageRoleList(@RequestBody DataPage<Role> dataPage){
		return roleServiceImpl.pageRoleList(dataPage);
	}

	@PostMapping("/allRolesList")
	ModelResult<List<Role>> allRolesList(){
		return roleServiceImpl.allRolesList();
	}

	@PostMapping("/insertSelective")
	ModelResult<Integer> insertSelective(@RequestBody Role role){
		return roleServiceImpl.insertSelective(role);
	}

	@GetMapping("/selectByPrimaryKey/{roleId}")
	ModelResult<Role> selectByPrimaryKey(@PathVariable("roleId")Integer roleId){
		return roleServiceImpl.selectByPrimaryKey(roleId);
	}

	@PostMapping("/updateByPrimaryKeySelective")
	ModelResult<Integer> updateByPrimaryKeySelective(@RequestBody Role role){
		return roleServiceImpl.updateByPrimaryKeySelective(role);
	}

	@GetMapping("/deleteByPrimaryKeys/{roleIds}")
	ModelResult<Integer> deleteByPrimaryKeys(@PathVariable("roleIds")String roleIds){
		return roleServiceImpl.deleteByPrimaryKeys(roleIds);
	}
}
