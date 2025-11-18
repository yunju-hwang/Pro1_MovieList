package com.itwillbs.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.domain.FaqsVO;
import com.itwillbs.domain.InquiriesVO;
import com.itwillbs.domain.MemberVO;
import com.itwillbs.domain.MovieRequestVO;
import com.itwillbs.domain.MovieVO;
import com.itwillbs.domain.ReservationsVO;
import com.itwillbs.domain.ReviewsVO;
import com.itwillbs.mapper.AdminMapper;


@Service
public class AdminService {
	@Inject
	private AdminMapper adminMapper;
	
    public MemberVO loginAdmin(MemberVO loginVO) {
        
        MemberVO resultVO = adminMapper.loginAdmin(loginVO);

        return resultVO;
    }
	
//    대쉬보드 
    public int getUserCount() {
    	return adminMapper.getUserCount();
    }
    
    public int getReviewsCount() {
		return adminMapper.getReviewsCount();
    }
    
    public int getReservationsCount() {
    	return adminMapper.getReservationsCount();
    }
    
    
    public int getInquiriesCount() {
    	return adminMapper.getInquiriesCount();
    }
    
    public int getMovie_RequestsCount() {
    	return adminMapper.getMovie_RequestsCount();
    }
    
//    영화 관리
    public List<MovieVO> AdminMovieList(){
    	return adminMapper.AdminMovieList();
    }
    
    
    public int deleteMovie(int tmdbId) {
		return adminMapper.deleteMovie(tmdbId);
	}

//    사용자 관리
    public List<MemberVO> AdminUserList(){
    	return adminMapper.AdminUserList();
    }
    
    public int deleteUsers(String user_id) {
		return adminMapper.deleteUsers(user_id);
	}
    
//   1:1문의 
    public List<InquiriesVO> AdminInquiriesList() {
		return adminMapper.AdminInquiriesList();
	}

    public void answerInquiry(int id, String answerContent) {
    	adminMapper.answerInquiry(id, answerContent);
	}

    public InquiriesVO getInquiryDetail(int id) {
		return adminMapper.getInquiryDetail(id);
    	
    }
    
// 영화 요청
    public List<MovieRequestVO> AdminRequestList(){
    	return adminMapper.AdminRequestList();
    }
    
//    public int deleteMovieRequests(int userId) {
//    	return adminMapper.deleteMovieRequests(userId);
//    }

    
 // 리뷰 관리
    public List<ReviewsVO> AdminReviewsList(){
    	return adminMapper.AdminReviewsList();
    }
    
    public int deleteReviews(int id) {
    	return adminMapper.deleteReviews(id);
    }
    
// 예매 관리
    public List<ReservationsVO> AdminReservationsList(){
    	return adminMapper.AdminReservationsList();
    }
    
    public void AdminReservationsRefund(int id) {
    	adminMapper.AdminReservationsRefund(id);
    }
    
    // FAQS
    public List<FaqsVO> AdminFaqsList(){
    	return adminMapper.AdminFaqsList();
    }
    
    public int AdminFaqsWrite(FaqsVO faqs) {
    	return adminMapper.AdminFaqsWrite(faqs);
    }
    
    public FaqsVO getFaqsDetail(int id) {
    	return adminMapper.getFaqsDetail(id);
    }
    
    public int AdminFaqsUpdate(FaqsVO faqs) {
    	return adminMapper.AdminFaqsUpdate(faqs);
    }
    
    public int AdminFaqsDelete(int id) {
    	return adminMapper.AdminFaqsDelete(id);
    }
    
    
}
