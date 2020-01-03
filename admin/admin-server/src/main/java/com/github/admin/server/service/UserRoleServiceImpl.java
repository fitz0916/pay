package com.github.admin.server.service;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.math.NumberUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.admin.common.constants.Constants;
import com.github.admin.common.domain.UserRole;
import com.github.admin.common.service.UserRoleService;
import com.github.admin.server.dao.UserRoleDao;
import com.github.appmodel.domain.result.ModelResult;

@Service
public class UserRoleServiceImpl implements UserRoleService {

	@Autowired
	private UserRoleDao userRoleDao;
	
	@Override
	public ModelResult<List<UserRole>> selectByUserId(Integer userId) {
		ModelResult<List<UserRole>> modelResult = new ModelResult<List<UserRole>>();
		if(userId == null || userId == 0) {
			modelResult.withError(Constants.FAIL_MSG_CODE, "用户ID为空或非法参数");
			return modelResult;
		}
		List<UserRole> list = userRoleDao.selectByUserId(userId);
		modelResult.setModel(list);
		return modelResult;
	}

	@Override
	@Transactional
	public ModelResult<Integer> role(String[] roleIds, Integer userId) {
		ModelResult<Integer> modelResult = new ModelResult<Integer>();
		if(roleIds == null || userId == null || userId == 0) {
			modelResult.withError(Constants.FAIL_MSG_CODE, "用户角色ID为空或非法参数");
			return modelResult;
		}
		int result = 0;
        // 删除用户的旧记录
        userRoleDao.deleteByUserId(userId);
        // 增加新记录
        for (String roleId : roleIds) {
            if (StringUtils.isBlank(roleId)) {
                continue;
            }
            UserRole userRole = new UserRole();
            userRole.setUserId(userId);
            userRole.setRoleId(NumberUtils.toInt(roleId));
            result = userRoleDao.insertSelective(userRole);
        }
        if(result > 0) {
			modelResult.setModel(result);
		}else {
			modelResult.withError(Constants.FAIL_MSG_CODE,Constants.UPDATE_FAIL_MSG);
		}
		return modelResult;
	}

}
