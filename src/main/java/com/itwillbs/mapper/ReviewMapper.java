package com.itwillbs.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;


import com.itwillbs.domain.ReviewsVO;


@Mapper
public interface ReviewMapper {
	void insertReview(ReviewsVO review);
	List<ReviewsVO> selectReviewListByTmdbId(int tmdbId);
	List<ReviewsVO> selectByUserId(String userId);
}
