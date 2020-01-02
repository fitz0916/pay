package com.github.admin.server.service;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.math.NumberUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.admin.common.constants.Constants;
import com.github.admin.common.domain.UserOrganization;
import com.github.admin.common.service.UserOrganizationService;
import com.github.admin.server.dao.UserOrganizationDao;
import com.github.appmodel.domain.result.ModelResult;

@Service
public class UserOrganizationServiceImpl implements UserOrganizationService{

	@Autowired
	private UserOrganizationDao userOrganizationDao;
	
	@Override
	@Transactional
	public ModelResult<Integer> insertSelective(String[] organizationIds, Integer userId) {
		ModelResult<Integer> modelResult = new ModelResult<Integer>();
		if(organizationIds == null || userId == null || userId == 0) {
			modelResult.withError(Constants.FAIL_MSG_CODE, "组织或用户id为空");
			return modelResult;
		}
		int result = 0;
		userOrganizationDao.deleteByUserId(userId);
		for (String organizationId : organizationIds) {
              if (StringUtils.isBlank(organizationId)) {
                  continue;
              }
              UserOrganization userOrganization = new UserOrganization();
              userOrganization.setUserId(userId);
              userOrganization.setOrganizationId(NumberUtils.toInt(organizationId));
              result = userOrganizationDao.insertSelective(userOrganization);
          }
		if(result > 0) {
			modelResult.setModel(result);
		}else {
			modelResult.withError(Constants.FAIL_MSG_CODE,Constants.ADD_FAIL_MSG);
		}
		return modelResult;
	}

	@Override
	public ModelResult<List<UserOrganization>> selectByUserId(Integer userId) {
		ModelResult<List<UserOrganization>> modelResult = new ModelResult<List<UserOrganization>>();
		if(userId == null || userId == 0) {
			modelResult.withError(Constants.FAIL_MSG_CODE, "用户id为空");
			return modelResult;
		}
		List<UserOrganization> list = userOrganizationDao.selectByUserId(userId);
		modelResult.setModel(list);
		return modelResult;
	}

}
