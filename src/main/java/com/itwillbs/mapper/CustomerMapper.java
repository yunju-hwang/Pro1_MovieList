package com.itwillbs.mapper;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.domain.InquiriesVO;
import com.itwillbs.domain.MovieRequestVO;

//interface로 구현
@Mapper
public interface CustomerMapper {

	int movie_request_count(String userId);

	void insertinquirty(InquiriesVO inquiriesVO);

	List<InquiriesVO> inquiries(String userId);

	int inquiry_count(String userId);

	InquiriesVO inquiry_update(int id);

	void inquiry_delete(int id);

	List<InquiriesVO> inquiry_detail(String userId);

	List<MovieRequestVO> movie_request(String userId);

	void insert_movie_request(MovieRequestVO movieRequestVO);

	

}
