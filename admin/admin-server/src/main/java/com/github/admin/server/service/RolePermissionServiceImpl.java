package com.github.admin.server.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.github.admin.common.constants.Constants;
import com.github.admin.common.domain.RolePermission;
import com.github.admin.common.service.RolePermissionService;
import com.github.admin.server.dao.RolePermissionDao;
import com.github.appmodel.domain.result.ModelResult;

@Service
public class RolePermissionServiceImpl implements RolePermissionService{

	@Autowired
    private RolePermissionDao rolePermissionDao;
	
	@Override
	@Transactional
	public ModelResult<Integer> rolePermission(JSONArray datas, Integer roleId) {
		ModelResult<Integer> modelResult = new ModelResult<Integer>();
		if(datas == null || roleId == null || roleId == 0) {
			modelResult.withError(Constants.FAIL_MSG_CODE, "请求包含非法参数");
			return modelResult;
		}
		List<Integer> deleteIds = new ArrayList<>();
		for (int i = 0; i < datas.size(); i ++) {
            JSONObject json = datas.getJSONObject(i);
            if (!json.getBoolean("checked")) {
                deleteIds.add(json.getIntValue("id"));
            } else {
                // 新增权限
                RolePermission upmsRolePermission = new RolePermission();
                upmsRolePermission.setRoleId(roleId);
                upmsRolePermission.setPermissionId(json.getIntValue("id"));
                rolePermissionDao.insertSelective(upmsRolePermission);
            }
        }
        // 删除权限
        if (deleteIds.size() > 0) {
            for (Integer permissionId:deleteIds){
            	rolePermissionDao.deleteByRoleIdAndPermissionId(roleId,permissionId);
            }
        }
        int result = datas.size();
        if(result > 0) {
			modelResult.setModel(result);
		}else {
			modelResult.withError(Constants.FAIL_MSG_CODE,Constants.UPDATE_FAIL_MSG);
		}
		return modelResult;
	}

}
