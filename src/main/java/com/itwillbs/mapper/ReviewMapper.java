package com.itwillbs.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.domain.ReviewsVO;


@Mapper
public interface ReviewMapper {
	void insertReview(ReviewsVO review);
	List<ReviewsVO> selectReviewListByTmdbId(Map<String, Object> params);
	List<ReviewsVO> selectByUserId(String userId);
	
	int updateReview(ReviewsVO reviews);
	
	ReviewsVO selectReviewById(int reviewId);
	int deleteReview(int reviewId);
	int selectReviewCountByTmdbId(int tmdbId);
}
