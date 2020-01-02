package com.github.admin.common.service;

import java.util.List;

import com.github.admin.common.domain.Role;
import com.github.admin.common.vo.PageVo;
import com.github.appmodel.domain.result.ModelResult;
import com.github.appmodel.page.DataPage;

public interface RoleService {

	/***
	 * 根据userId查询角色
	 * @param userId
	 * @return
	 */
	public ModelResult<List<Role>> selectRoleByUserId(Integer userId);

	/***
	 * 分页查询
	 * @param dataPage
	 * @return
	 */
	public ModelResult<PageVo> pageRoleList(DataPage<Role> dataPage);

	/***
	 * 查询所以角色
	 * @return
	 */
	public ModelResult<List<Role>> allRolesList();

	/***
	 * 添加角色
	 * @param role
	 * @return
	 */
	public ModelResult<Integer> insertSelective(Role role);

	/***
	 * 根据roleid查询角色
	 * @param roleId
	 * @return
	 */
	public ModelResult<Role> selectByPrimaryKey(Integer roleId);
	
    /***
     * 更新角色
     * @param role
     * @return
     */
	public ModelResult<Integer> updateByPrimaryKeySelective(Role role);

	/***
	 * 根据角色ids删除角色，以”-“作为分隔符
	 * @param roleIds
	 * @return
	 */
	public ModelResult<Integer> deleteByPrimaryKeys(String roleIds);
}
