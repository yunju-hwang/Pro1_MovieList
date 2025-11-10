package com.itwillbs.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.itwillbs.service.CustomerService;

@Controller
public class CustomerController {

	@Inject
	private CustomerService customerService;
	
	// 고객센터 공지사항
	@GetMapping("/customer/notices")
	public String notices() {
		return "/customer/notices";
	}
	@GetMapping("/customer/notice_detail")
	public String notice_detail() {
		return "/customer/notice_detail";
	}
	
	// 고객센터 FAQ
	@GetMapping("/customer/faqs")
	public String faqs() {
		return "/customer/faqs";
	}
	

	
	// 고객센터 1:1 문의
	@GetMapping("/customer/inquiries")
	public String inquiries() {
		return "/customer/inquiries/inquiries";
	}
	@GetMapping("customer/write_inquiry")
	public String write_inquiry() {
		return "/customer/inquiries/write_inquiry";
	}
	
	// 고객센터 영화 요청
	@GetMapping("/customer/movie_request")
	public String movieRequest() {
		return "/customer/movie_request/movie_request";
	}

	// 약관 및 정책 (이용약관)
	@GetMapping("/terms")
	public String terms() {
		return "/terms/terms_of_service";
	}

	
	// 약관 및 정책 (개인정보처리방침)
	@GetMapping("/terms/policy")
	public String policy() {
		return "/terms/privacy_policy";
	}
	
	// 약관 및 정책 (청소년 보호정책)
	@GetMapping("/terms/youth")
	public String youth() {
		return "/terms/youth_policy";
	}
	
	
	// 약관 및 정책 (위치기반서비스)
	@GetMapping("/terms/location")
	public String locationTerms() {
		return "/terms/location_terms";
	}
	
}
