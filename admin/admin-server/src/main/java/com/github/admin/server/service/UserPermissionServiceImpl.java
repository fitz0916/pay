package com.github.admin.server.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.github.admin.common.constants.Constants;
import com.github.admin.common.domain.UserPermission;
import com.github.admin.common.service.UserPermissionService;
import com.github.admin.server.dao.UserPermissionDao;
import com.github.appmodel.domain.result.ModelResult;

@Service
public class UserPermissionServiceImpl implements UserPermissionService{

	@Autowired
	private UserPermissionDao userPermissionDao;
	
	@Override
	@Transactional
	public ModelResult<Integer> permission(JSONArray datas, Integer userId) {
		ModelResult<Integer> modelResult = new ModelResult<Integer>();
		if(userId == null || userId == 0) {
			modelResult.withError(Constants.FAIL_MSG_CODE, "用户ID为空或非法参数");
			return modelResult;
		}
		int result = 0;
		for (int i = 0; i < datas.size(); i ++) {
            JSONObject json = datas.getJSONObject(i);
            if (json.getBoolean("checked")) {
                // 新增权限
                UserPermission userPermission = new UserPermission();
                userPermission.setUserId(userId);
                userPermission.setPermissionId(json.getIntValue("id"));
                userPermission.setType(json.getByte("type"));
                userPermissionDao.insertSelective(userPermission);
            } else {
                // 删除权限
            	userPermissionDao.deleteByTypeAndPermissionId(json.getIntValue("id"),json.getByte("type"));
            }
        }
		result = datas.size();
		if(result > 0) {
			modelResult.setModel(result);
		}else {
			modelResult.withError(Constants.FAIL_MSG_CODE,Constants.UPDATE_FAIL_MSG);
		}
		return modelResult;
	}

}
