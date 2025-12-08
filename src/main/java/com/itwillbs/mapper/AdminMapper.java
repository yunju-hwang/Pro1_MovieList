package com.itwillbs.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.domain.NoticesVO;
import com.itwillbs.domain.ReservationsVO;
import com.itwillbs.domain.ReviewsAdminVO;
import com.itwillbs.domain.ReviewsVO;
import com.itwillbs.domain.FaqsVO;
import com.itwillbs.domain.InquiriesVO;
import com.itwillbs.domain.MemberVO;
import com.itwillbs.domain.MovieRequestVO;
import com.itwillbs.domain.MovieVO;

//interface로 구현
@Mapper
public interface AdminMapper {

	MemberVO loginAdmin(MemberVO loginVO);

	
//대쉬보드 
public	int getUserCount();

public int getReviewsCount();

public int getReservationsCount();

public int getInquiriesCount();

public int getMovie_RequestsCount();


//영화관리
public List<MovieVO> AdminMovieList(Map<String, Object> params);

public int deleteMovie(int tmdbId);

//사용자 관리
public List<MemberVO> AdminUserList(Map<String, Object> params);

public int deleteUsers(String user_id);

//1:1문의
public List<InquiriesVO> AdminInquiriesList(Map<String, Object> params);


public void answerInquiry(@Param("id") int id, @Param("answerContent") String answerContent);

public InquiriesVO getInquiryDetail(int id);

// 영화 요청
public List<MovieRequestVO> AdminRequestList(Map<String, Object> params);

public void updateMovieRequests(Map<String, Object> params);

public void deleteMovieRequests(Map<String, Object> params);

public MovieRequestVO getMovieRequestDetail(int id);

// 리뷰 관리
public List<ReviewsAdminVO> AdminReviewsList(Map<String, Object> params);

public ReviewsAdminVO AdminReviewsDetail(int id);

public int deleteReviews(int id);

// 예매 관리
public List<ReservationsVO> AdminReservationsList(Map<String, Object> params);

public ReservationsVO AdminReservationDetail(int id);

public void AdminReservationsRefund(int id);

// FAQS
public List<FaqsVO> AdminFaqsList(Map<String, Object> params);

public int AdminFaqsWrite(FaqsVO faqs);

public FaqsVO getFaqsDetail(int id);

public int AdminFaqsUpdate(FaqsVO faqs);

public int AdminFaqsDelete(int id);


// 공지사항
public List<NoticesVO> AdminNoticesList(Map<String, Object> params);

public int AdminNoticesWrite(NoticesVO notices);

public NoticesVO getNoticesDetail(int id);

public int AdminNoticesUpdate(NoticesVO notices);

public int AdminNoticesDelete(int id);













}