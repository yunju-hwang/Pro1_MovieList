package com.itwillbs.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MypageController {

	// 마이페이지 -> 관심 영화 목록
	@GetMapping("/")
	public String favorites() {
		return "/mypage/favorites";
	}
	
	// 마이페이지 -> 문의 목록
	@GetMapping("/mypage/inquiries")
	public String inquiries() {
		return "/mypage/inquiries";
	}
	
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
