package com.itwillbs.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.domain.FaqsVO;
import com.itwillbs.domain.InquiriesVO;
import com.itwillbs.domain.MemberVO;
import com.itwillbs.domain.MovieRequestVO;
import com.itwillbs.domain.MovieVO;
import com.itwillbs.domain.NoticesVO;
import com.itwillbs.domain.ReservationsVO;
import com.itwillbs.domain.ReviewsAdminVO;
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
    public List<MovieVO> AdminMovieList(Map<String, Object> params){
    	return adminMapper.AdminMovieList(params);
    }
    
    
    public int deleteMovie(int tmdbId) {
		return adminMapper.deleteMovie(tmdbId);
	}

//    사용자 관리
    public List<MemberVO> AdminUserList(Map<String, Object> params){
    	return adminMapper.AdminUserList(params);
    }
    
    public int deleteUsers(String user_id) {
		return adminMapper.deleteUsers(user_id);
	}
    
//   1:1문의 
    public List<InquiriesVO> AdminInquiriesList(Map<String, Object> params) {
		return adminMapper.AdminInquiriesList(params);
	}

    public void answerInquiry(int id, String answerContent) {
    	adminMapper.answerInquiry(id, answerContent);
	}

    public InquiriesVO getInquiryDetail(int id) {
		return adminMapper.getInquiryDetail(id);
    	
    }
    
// 영화 요청
    public List<MovieRequestVO> AdminRequestList(Map<String, Object> params){
    	return adminMapper.AdminRequestList(params);
    }
    public void updateMovieRequests(String[] idArray, String status) {
        // 1. Map 객체 생성
        Map<String, Object> params = new HashMap<>(); 
        // 2. ID 배열과 상태를 Map에 담기. (Mapper의 <foreach collection="ids">와 연결됨)
        params.put("ids", idArray);
        params.put("status", status);
        
        // 3. Mapper 호출
     	adminMapper.updateMovieRequests(params); // <--- Mapper.java의 메서드와 연결
    }

    public void deleteMovieRequests(String[] idArray) {
        // 1. Map 객체 생성
        Map<String, Object> params = new HashMap<>();
        // 2. ID 배열을 Map에 담기
        params.put("ids", idArray); 
        
        // 3. Mapper 호출
     	adminMapper.deleteMovieRequests(params); // <--- Mapper.java의 메서드와 연결
    }

    public MovieRequestVO getMovieRequestDetail(int id) {
        return adminMapper.getMovieRequestDetail(id);
    }
                      

    
    
 // 리뷰 관리
    public List<ReviewsAdminVO> AdminReviewsList(Map<String, Object> params){
    	return adminMapper.AdminReviewsList(params);
    }
    
	public ReviewsAdminVO AdminReviewsDetail(int id) {
		return adminMapper.AdminReviewsDetail(id);
	}
    
    public int deleteReviews(int id) {
    	return adminMapper.deleteReviews(id);
    }
    
// 예매 관리
    public List<ReservationsVO> AdminReservationsList(Map<String, Object> params){
    	return adminMapper.AdminReservationsList(params);
    }
    
	public ReservationsVO AdminReservationDetail(int id) {
		return adminMapper.AdminReservationDetail(id);
	}
    
   
    public void AdminReservationsRefund(int id) {
    	adminMapper.AdminReservationsRefund(id);
    }
    
    // FAQS
    public List<FaqsVO> AdminFaqsList(Map<String, Object> params){
    	return adminMapper.AdminFaqsList(params);
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
    
    // 공지사항
    public List<NoticesVO> AdminNoticesList(Map<String, Object> params){
    	return adminMapper.AdminNoticesList(params);
    }
    
    public int AdminNoticesWrite(NoticesVO notices) {
    	return adminMapper.AdminNoticesWrite(notices);
    }
    
    public NoticesVO getNoticesDetail(int id) {
    	return adminMapper.getNoticesDetail(id);
    }
    
    public int AdminNoticesUpdate(NoticesVO notices) {
    	return adminMapper.AdminNoticesUpdate(notices);
    }
    
    public int AdminNoticesDelete(int id) {
    	return adminMapper.AdminNoticesDelete(id);
    }




    
    
}
