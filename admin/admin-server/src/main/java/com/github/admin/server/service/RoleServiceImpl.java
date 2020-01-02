package com.github.admin.server.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.admin.common.constants.Constants;
import com.github.admin.common.domain.Role;
import com.github.admin.common.service.RoleService;
import com.github.admin.server.dao.RoleDao;
import com.github.appmodel.domain.result.ModelResult;

@Service
public class RoleServiceImpl implements RoleService{
	
	private static Logger logger = LoggerFactory.getLogger(RoleServiceImpl.class);
	
	@Autowired
	private RoleDao roleDao;
	
	public ModelResult<List<Role>> selectRoleByUserId(Integer userId){
		ModelResult<List<Role>> modelResult = new ModelResult<List<Role>>();
		logger.info("根据userId = 【{}】查询用户对应的角色",userId);
		if(userId == null) {
			logger.error("当前userId为空！");
			modelResult.withError(Constants.FAIL_MSG_CODE,Constants.QUERY_FAIL_MSG);
			return modelResult;
		}
		List<Role> list = roleDao.selectRoleByUserId(userId);
		modelResult.setModel(list);
		return modelResult;
	}

}
