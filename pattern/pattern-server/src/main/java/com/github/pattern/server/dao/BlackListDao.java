package com.github.pattern.server.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.github.pattern.common.domain.BlackList;

@Repository
public interface BlackListDao {
	
    int deleteByPrimaryKey(@Param("blackListId")Integer blackListId);

    int insert(BlackList record);

    int insertSelective(BlackList record);

    BlackList selectByPrimaryKey(@Param("blackListId")Integer blackListId);

    int updateByPrimaryKeySelective(BlackList record);

    int updateByPrimaryKey(BlackList record);

	long pageCount();

	List<BlackList> pageList(@Param("start")int start, @Param("offset")int offset);
}