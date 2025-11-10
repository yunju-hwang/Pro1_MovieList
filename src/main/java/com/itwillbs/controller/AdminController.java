package com.itwillbs.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.itwillbs.domain.MemberVO;
import com.itwillbs.mapper.AdminMapper;
import com.itwillbs.service.AdminService;
import com.mysql.cj.Session;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Inject
	private	AdminMapper adminService;
	
	/* 
	// 관리자 대시보드
	@GetMapping("/dashboard")
	public String dashboard(HttpSession session) {
		String userID = (String) session.getAttribute("user_id");
		String role = (String) session.getAttribute("role");
		if(userID == null || !"admin".equals(role)) {
			return "redirect:/login";
			
		}
		return "/admin/dashboard";
	}
	
	// 사용자 관리
	@GetMapping("/users")
	public String users(HttpSession session) {
		String userID = (String) session.getAttribute("user_id");
		String role = (String) session.getAttribute("role");
		if(userID == null || !"admin".equals(role)) {
			return "redirect:/login";
			
		}
		return "/admin/users";
	}
	
	// 영화 관리
	@GetMapping("/movie")
	public String movie(HttpSession session) {
		String userID = (String) session.getAttribute("user_id");
		String role = (String) session.getAttribute("role");
		if(userID == null || !"admin".equals(role)) {
			return "redirect:/login";
			
		}
		return "/admin/movie";
	}
	
	// 리뷰 관리
	@GetMapping("/reviews")
	public String reviews(HttpSession session) {
		String userID = (String) session.getAttribute("user_id");
		String role = (String) session.getAttribute("role");
		if(userID == null || !"admin".equals(role)) {
			return "redirect:/login";
			
		}
		return "/admin/reviews";
	}
	
	// 예매 관리
	@GetMapping("/reservations")
	public String reservations(HttpSession session) {
		String userID = (String) session.getAttribute("user_id");
		String role = (String) session.getAttribute("role");
		if(userID == null || !"admin".equals(role)) {
			return "redirect:/login";
			
		}
		return "/admin/reservations";
	}

	// 1:1 문의 관리
	@GetMapping("/inquiries")
	public String locationTerms(HttpSession session) {
		String userID = (String) session.getAttribute("user_id");
		String role = (String) session.getAttribute("role");
		if(userID == null || !"admin".equals(role)) {
			return "redirect:/login";
			
		}
		return "/admin/inquiries";
	}
	
	// 관리자 대시보드
	@GetMapping("/movie_requests")
	public String movieRequests(HttpSession session) {
		String userID = (String) session.getAttribute("user_id");
		String role = (String) session.getAttribute("role");
		if(userID == null || !"admin".equals(role)) {
			return "redirect:/login";
			
		}
		return "/admin/movie_requests";
	}
	
	// 공지사항 관리
	@GetMapping("/notices")
	public String notice(HttpSession session) {
		String userID = (String) session.getAttribute("user_id");
		String role = (String) session.getAttribute("role");
		if(userID == null || !"admin".equals(role)) {
			return "redirect:/login";
			
		}
		return "/admin/notices";
	}
	
	// FAQ 관리
	@GetMapping("/faqs")
	public String faqs(HttpSession session) {
		String userID = (String) session.getAttribute("user_id");
		String role = (String) session.getAttribute("role");
		if(userID == null || !"admin".equals(role)) {
			return "redirect:/login";
			
		}
		return "/admin/faqs";
	}
	*/

	// 관리자 대시보드
		@GetMapping("/dashboard")
		public String dashboard(Model model) {
		
			int userCount = adminService.getUserCount();
			int reviewsCount = adminService.getReviewsCount();
			int reservations = adminService.getReservationsCount();
			int inquieresCount = adminService.getInquieresCount();
			int movie_RequestsCount = adminService.getMovie_RequestsCount();
			
			model.addAttribute("userCount", userCount);
			model.addAttribute("reviewsCount", reviewsCount);
			model.addAttribute("reservations", reservations);
			model.addAttribute("inquieresCount", inquieresCount);
			model.addAttribute("movie_RequestsCount", movie_RequestsCount);
			
			
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
	// ----------------------------------

	
	
	
}
