package com.github.pattern.server.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.github.pattern.common.domain.WhiteList;


@Repository
public interface WhiteListDao {
	
	
    int deleteByPrimaryKey(@Param("whiteListId")Integer whiteListId);

    int insert(WhiteList record);

    int insertSelective(WhiteList record);

    WhiteList selectByPrimaryKey(@Param("whiteListId")Integer whiteListId);

    int updateByPrimaryKeySelective(WhiteList record);

    int updateByPrimaryKey(WhiteList record);

	long pageCount();

	List<WhiteList> pageList(@Param("start")int start, @Param("offset")int offset);
}