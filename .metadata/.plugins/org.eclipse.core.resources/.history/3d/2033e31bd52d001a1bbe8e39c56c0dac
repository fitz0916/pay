package com.github.admin.server.service;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.admin.common.domain.Permission;
import com.github.admin.common.service.PermissionService;
import com.github.admin.server.dao.PermissionDao;
import com.github.appmodel.domain.result.ModelResult;

@Service
public class PermissionServiceImpl implements PermissionService {

	private static Logger logger = LoggerFactory.getLogger(PermissionServiceImpl.class);
	
	@Autowired
	private PermissionDao permissionDao;
	
	
	@Override
	public ModelResult<List<Permission>> selectPermissionByUserId(Integer systemId, Integer userId) {
		logger.info("根据systemId = 【{}】，userId = 【{}】查询用户权限！",systemId,userId);
		ModelResult<List<Permission>> modelResult = new ModelResult<List<Permission>>();
		if(systemId == null || userId == null) {
			logger.error("系统对应的systemId或者账号对应的userId为空！");
			modelResult.withError("0","系统ID或者账号ID为空！");
			return modelResult;
		}
		List<Permission> permissions = permissionDao.selectPermissionByUserId(systemId,userId);
		modelResult.setModel(permissions);
		return modelResult;
	}

}
