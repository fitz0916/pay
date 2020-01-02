package com.github.admin.server.service;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.admin.common.constants.Constants;
import com.github.admin.common.domain.User;
import com.github.admin.common.service.UserService;
import com.github.admin.server.dao.UserDao;
import com.github.appmodel.domain.result.ModelResult;

@Service
public class UserServiceImpl implements UserService{

	private static Logger logger = LoggerFactory.getLogger(UserServiceImpl.class);
	
	@Autowired
	private UserDao userDao;
	
	@Override
	public ModelResult<User> selectUserByUserName(String userName) {
		ModelResult<User> modelResult = new ModelResult<User>();
		if(StringUtils.isBlank(userName)) {
			logger.error("当前账号为空！");
			modelResult.withError(Constants.FAIL_MSG_CODE,Constants.QUERY_FAIL_MSG);
			return modelResult;
		}
		User user = userDao.selectUserByUserName(userName);
		modelResult.setModel(user);
		return modelResult;
	}

}
