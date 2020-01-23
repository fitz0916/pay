package com.github.pattern.server.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.github.pattern.common.domain.Shop;


@Repository
public interface ShopDao {
	
	
    int deleteByPrimaryKey(@Param("shopId")Integer shopId);

    int insert(Shop record);

    int insertSelective(Shop record);

    Shop selectByPrimaryKey(@Param("shopId")Integer shopId);
    
    Shop selectByShopName(@Param("shopName")String shopName);

    int updateByPrimaryKeySelective(Shop record);

    int updateByPrimaryKey(Shop record);
    
	long pageCount(@Param("statusList")List<Integer> statusList, @Param("agentId")Integer agentId);

	List<Shop> pageList(@Param("start")Integer start, @Param("offset")Integer offset,@Param("statusList")List<Integer> status,@Param("agentId")Integer agentId);
	
	List<Shop> selectByAgentId(@Param("statusList")List<Integer> status,@Param("agentId")Integer agentId);
}