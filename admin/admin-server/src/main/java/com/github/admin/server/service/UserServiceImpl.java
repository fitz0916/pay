package com.github.admin.server.service;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.admin.common.constants.Constants;
import com.github.admin.common.domain.User;
import com.github.admin.common.domain.UserInfo;
import com.github.admin.common.request.UserRequest;
import com.github.admin.common.service.UserService;
import com.github.admin.server.dao.UserDao;
import com.github.admin.server.dao.UserOrganizationDao;
import com.github.admin.server.dao.UserPermissionDao;
import com.github.admin.server.dao.UserRoleDao;
import com.github.appmodel.domain.result.ModelResult;
import com.github.appmodel.page.DataPage;
import com.github.appmodel.vo.PageVo;

@Service
public class UserServiceImpl implements UserService{

	private static Logger logger = LoggerFactory.getLogger(UserServiceImpl.class);
	
	@Autowired
	private UserDao userDao;
	@Autowired
	private UserRoleDao userRoleDao;
	@Autowired
	private UserPermissionDao userPermissionDao;
	@Autowired
	private UserOrganizationDao userOrganizationDao;
	
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

	@Override
	public ModelResult<PageVo> pageUserInfoList(UserRequest userRequest) {
		ModelResult<PageVo> modelResult = new ModelResult<PageVo>();
		PageVo pageVo = new PageVo();
		DataPage<UserInfo> dataPage = new DataPage<UserInfo>();
		dataPage.setPageSize(userRequest.getLimit());
		dataPage.setPageNo(userRequest.getOffset()/userRequest.getLimit()+1);
		String userName = userRequest.getUserName();
		String organizationName = userRequest.getOrganizationName();
		Integer roleId = userRequest.getRoleId();
		int start = dataPage.getStartIndex();
		int offset = dataPage.getPageSize();
		long totalCount = userDao.pageUserInfoListCount(userName,organizationName,roleId);
		List<UserInfo> result = userDao.pageUserInfoList(userName,organizationName,roleId,start,offset);
        dataPage.setDataList(result);
        pageVo.setRows(result);
        pageVo.setTotal(totalCount);
        modelResult.setModel(pageVo);
        return modelResult;
	}

	@Override
	public ModelResult<Integer> insertSelective(User user) {
		ModelResult<Integer> modelResult = new ModelResult<Integer>();
		if(user == null || StringUtils.isBlank(user.getUserName()) || StringUtils.isBlank(user.getPassword())) {
			modelResult.withError(Constants.FAIL_MSG_CODE, "添加账号名称或密码为空！");
			return modelResult;
		}
		String userName = user.getUserName();
		User existUser = userDao.selectUserByUserName(userName);
		if(existUser != null) {
			logger.error("当前账号userName = 【{}】已存在");
			modelResult.withError(Constants.FAIL_MSG_CODE, "账号已经存在");
			return modelResult;
		}
		int result = userDao.insertSelective(user);
		logger.info("添加账号操作返回结果result = 【{}】",result);
		if(result > 0) {
			modelResult.setModel(result);
		}else {
			modelResult.withError(Constants.FAIL_MSG_CODE,Constants.ADD_FAIL_MSG);
		}
		return modelResult;
	}

	@Override
	public ModelResult<User> selectByPrimaryKey(Integer userId) {
		ModelResult<User> modelResult = new ModelResult<User> ();
		if(userId == null || userId == 0) {
			modelResult.withError(Constants.FAIL_MSG_CODE, "用户id为空或非法输入");
			return modelResult;
		}
		User user = userDao.selectByPrimaryKey(userId);
		modelResult.setModel(user);
		return modelResult;
	}

	@Override
	public ModelResult<Integer> updateByPrimaryKey(User user) {
		ModelResult<Integer> modelResult = new ModelResult<Integer>();
		if(user == null || user.getUserId() == null || user.getUserId() == 0) {
			modelResult.withError(Constants.FAIL_MSG_CODE, "用户id为空或非法输入");
			return modelResult;
		}
		int result = userDao.updateByPrimaryKeySelective(user);
		if(result > 0) {
			modelResult.setModel(result);
		}else {
			modelResult.withError(Constants.FAIL_MSG_CODE,Constants.UPDATE_FAIL_MSG);
		}
		return modelResult;
	}

	@Override
	@Transactional
	public ModelResult<Integer> deleteByPrimaryKey(String ids) {
		ModelResult<Integer> modelResult = new ModelResult<Integer>();
		if (StringUtils.isBlank(ids)) {
			modelResult.withError(Constants.FAIL_MSG, Constants.DELETE_FAIL_MSG);
			return modelResult;
		}
		String[] idArray = ids.split("-");
		int result = 0;
		for (String idStr : idArray) {
			if (StringUtils.isBlank(idStr)) {
				continue;
			}
			Integer userId = Integer.parseInt(idStr);
			userRoleDao.deleteByUserId(userId);
			userPermissionDao.deleteByUserId(userId);
			userOrganizationDao.deleteByUserId(userId);
			result += userDao.deleteByPrimaryKey(userId);
		}
		if(result > 0) {
			modelResult.setModel(result);
		}else {
			modelResult.withError(Constants.FAIL_MSG_CODE,Constants.DELETE_FAIL_MSG);
		}
		return modelResult;
	}

}
