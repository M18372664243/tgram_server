package com.youzan.pfcase.mapper;

import org.springframework.stereotype.Repository;

import com.youzan.pfcase.domain.Recommend;

import java.util.List;

/**
 * Created by sunjun on 16/8/2.
 */
@Repository
public interface RecommendMapper {

	List<Recommend> getAllRecommend();
}
