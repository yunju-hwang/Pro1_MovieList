package com.itwillbs.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MypageController {

	// 마이페이지 -> 관심 영화 목록
	@GetMapping("/mypage/favorites")
	public String favorites() {
		return "/mypage/favorites";
	}
	
	// 마이페이지 -> 문의 목록
	@GetMapping("/mypage/inquiries")
public String inquiries(Model model, HttpSession session) {
        
        // 1. 사용자 ID 가져오기 (세션에서 로그인된 사용자 ID를 'loginUserId' 키로 가정)
        String userId = (String) session.getAttribute("loginUserId"); 
        
        // 2. userId가 null이 아닐 경우에만 서비스 호출
        if (userId != null) {
            
            // 🚨🚨🚨 여기에 문의 건수를 가져오는 로직을 작성해야 합니다. 🚨🚨🚨
            // 주의: InquiryService 객체를 필드로 주입(Inject)해야 이 코드가 실행될 수 있습니다.
            
            // 예시 코드 (실제 실행을 위해서는 InquiryService 주입 및 메서드 구현 필요)
            // int count = inquiryService.getInquiryCountByUserId(userId);
            // model.addAttribute("inquiryCount", count);
            
            // 임시로 0건을 설정하여 JSP 테스트를 진행할 수 있습니다.
             int count = 0; 
             model.addAttribute("inquiryCount", count);
             
            // 문의 목록 리스트도 여기서 가져와 model에 담아야 합니다.
            // List<Inquiry> list = inquiryService.getInquiriesByUserId(userId);
            // model.addAttribute("inquiryList", list);
        }
        
		return "/mypage/inquiries"; // 이 JSP로 'inquiryCount' 데이터가 전달됩니다.
	}
	
	// (생략: payment(), movieRequest(), profile(), reservations(), theaters() 메서드)
	
	// 마이페이지 -> 결제 수단 등록
	@GetMapping("/mypage/paymentmethod")
	public String payment() {
		return "/mypage/payment_method";
	}
	
	// 마이페이지 -> 영화 요청 목록
	@GetMapping("/mypage/movierequest")
	public String movieRequest() {
		return "/mypage/movie_request";
	}
	
	// 마이페이지 -> 회원정보수정
	@GetMapping("/mypage/profile")
	public String profile() {
		return "/mypage/profile";
	}
	
	// 마이페이지 -> 영화 예약 조회
	@GetMapping("/mypage/reservations")
	public String reservations() {
		return "/mypage/reservations";
	}
	
	// 마이페이지 -> 선호 영화관 목록
	@GetMapping("/mypage/theaters")
	public String theaters() {
		return "/mypage/theaters";
	}
}
