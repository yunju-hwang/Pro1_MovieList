package com.itwillbs.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.domain.InquiriesVO;
import com.itwillbs.domain.MovieRequestVO;
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
	public String inquiries(HttpSession session, Model model) {
		String userId = (String)session.getAttribute("user_id");
		List<InquiriesVO> inquiry_list = customerService.inquiries(userId);
		
		int count = customerService.inquiry_count(userId);
		
		model.addAttribute("inquiry_list", inquiry_list);
		System.out.println(inquiry_list);
		model.addAttribute("count", count);
		
		return "/customer/inquiries/inquiries";
	}
	
	@GetMapping("/customer/inquiry_update")
	public String inquiry_update(Model model, HttpServletRequest request) {
		int id = Integer.parseInt(request.getParameter("id"));
		InquiriesVO inquiriesVO = customerService.inquiry_update(id);
		
		
		return "customer/write_inquiry";
	}
	
	@GetMapping("/customer/inquiry_delete")
	public String inquiry_delete(@RequestParam("id") int id) {
		
	    customerService.inquiry_delete(id);   // 서비스 호출

	    return "redirect:/customer/inquiries";  // 삭제 후 목록으로 이동
	}

	
	@GetMapping("/customer/write_inquiry")
	public String write_inquiry() {
		
		
		
		
		return "/customer/inquiries/write_inquiry";
	}
	

	
	@PostMapping("/customer/write_inquiry_pro")
	public String write_inquiry_pro(InquiriesVO inquiriesVO, HttpSession session) {
		inquiriesVO.setUserId((String)session.getAttribute("user_id"));
		
		System.out.println("inquiriesVO = " + inquiriesVO);
		customerService.insertinquiry(inquiriesVO);
		
		
		return "redirect:/customer/inquiries";
	}
	
	@GetMapping("/customer/inquiries/inquiry_detail")
	public String inquiry_detail(HttpSession session, Model model) {
		
		
	    String userId = (String) session.getAttribute("userId");

	    List<InquiriesVO> list = customerService.inquiry_detail(userId);
	    model.addAttribute("inquiries", list);

	    return "/customer/inquiries/inquiry_detail";
	}
	
	// 고객센터 영화 요청
	@GetMapping("/customer/movie_request")
	public String movie_request(HttpSession session, Model model) {
		String userId = (String)session.getAttribute("user_id");
		List<MovieRequestVO> movie_request_list = customerService.movie_request(userId);
		
		int count = customerService.movie_request_count(userId);
		
		model.addAttribute("movie_request_list", movie_request_list);
		System.out.println(movie_request_list);
		model.addAttribute("count", count);
		
		return "/customer/movie_request/movie_request";
	}
	
	// 영화 요청 작성
	@GetMapping("/customer/write_movie_request")
	public String writeMovieRequest() {
		return "/customer/movie_request/write_movie_request";	
	}
	
	
	@PostMapping("/customer/write_movie_request_pro")
	public String write_movie_request_pro(MovieRequestVO movieRequestVO, HttpSession session) {
		System.out.println("customerController write_movie_request_pro");
		movieRequestVO.setUserId((String)session.getAttribute("user_id"));
		
		System.out.println("movieRequestVO = " + movieRequestVO);
//		customerService.(movieRequestVO);
		
		
		return "redirect:/customer/movie_request";
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
