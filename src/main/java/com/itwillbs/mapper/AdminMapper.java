package com.itwillbs.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.domain.ReviewsVO;
import com.itwillbs.domain.NoticesVO;
import com.itwillbs.domain.ReservationsVO;
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
public List<MovieVO> AdminMovieList();

public int deleteMovie(int tmdbId);

//사용자 관리
public List<MemberVO> AdminUserList();

public int deleteUsers(String user_id);

//1:1문의
public List<InquiriesVO> AdminInquiriesList();


public void answerInquiry(@Param("id") int id, @Param("answerContent") String answerContent);

public InquiriesVO getInquiryDetail(int id);

// 영화 요청
public List<MovieRequestVO> AdminRequestList();

public int updateMovieRequests(@Param("id") int id, @Param("status") String status);

public int deleteMovieRequests(int id);

// 리뷰 관리
public List<ReviewsVO> AdminReviewsList();

public int deleteReviews(int id);

// 예매 관리
public List<ReservationsVO> AdminReservationsList();


public void AdminReservationsRefund(int id);

// FAQS
public List<FaqsVO> AdminFaqsList();

public int AdminFaqsWrite(FaqsVO faqs);

public FaqsVO getFaqsDetail(int id);

public int AdminFaqsUpdate(FaqsVO faqs);

public int AdminFaqsDelete(int id);


// Notices
public List<NoticesVO> AdminNoticesList();

public int AdminNoticesWrite(NoticesVO notices);

public NoticesVO getNoticesDetail(int id);

public int AdminNoticesUpdate(NoticesVO notices);

public int AdminNoticesDelete(int id);


}