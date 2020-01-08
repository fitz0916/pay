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

    int updateByPrimaryKeySelective(Shop record);

    int updateByPrimaryKey(Shop record);
    
    public List<Shop> selectByAgentId(@Param("shopId")Integer agentId,@Param("status")Integer status);
}