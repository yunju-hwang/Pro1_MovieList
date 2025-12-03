package com.itwillbs.mapper;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.domain.FaqsVO;
import com.itwillbs.domain.InquiriesVO;
import com.itwillbs.domain.MovieRequestVO;
import com.itwillbs.domain.NoticesVO;

//interface로 구현
@Mapper
public interface CustomerMapper {

	int movie_request_count(String userId);

	void insertinquirty(InquiriesVO inquiriesVO);

	List<InquiriesVO> inquiries(String userId);

	int inquiry_count(String userId);

	InquiriesVO getInquiryById(int id);
	


	InquiriesVO inquiry_detail(int id);

	List<MovieRequestVO> movie_request(String userId);

	void insert_movie_request(MovieRequestVO movieRequestVO);
	
	MovieRequestVO getMovieRequestById(int id);

	void updateMovieRequest(MovieRequestVO vo);

	void movie_request_delete(int id);

    List<NoticesVO> notices();   // 전체 공지 목록
    NoticesVO notice_detail(int id);    // 공지 상세

    List<FaqsVO> faqs();

	void updateInquiry(InquiriesVO vo);

	void inquiry_delete(int id);





}