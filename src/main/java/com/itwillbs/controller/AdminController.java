package com.itwillbs.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	
	// 관리자 대시보드
	@GetMapping("/dashboard")
	public String dashboard() {
		return "/admin/dashboard";
	}
	
	// 사용자 관리
	@GetMapping("/users")
	public String users() {
		return "/admin/users";
	}
	
	// 영화 관리
	@GetMapping("/movie")
	public String movie() {
		return "/admin/movie";
	}
	
	// 리뷰 관리
	@GetMapping("/reviews")
	public String reviews() {
		return "/admin/reviews";
	}
	
	// 예매 관리
	@GetMapping("/reservations")
	public String reservations() {
		return "/admin/reservations";
	}

	// 1:1 문의 관리
	@GetMapping("/inquiries")
	public String locationTerms() {
		return "/admin/inquiries";
	}
	
	// 관리자 대시보드
	@GetMapping("/movie_requests")
	public String movieRequests() {
		return "/admin/movie_requests";
	}
	
	// 공지사항 관리
	@GetMapping("/notices")
	public String notice() {
		return "/admin/notices";
	}
	
	// FAQ 관리
	@GetMapping("/faqs")
	public String faqs() {
		return "/admin/faqs";
	}
	

}
