package com.itwillbs.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.domain.InquiriesVO;
import com.itwillbs.domain.MemberVO;
import com.itwillbs.domain.MovieRequestVO;
import com.itwillbs.domain.MovieVO;
import com.itwillbs.domain.ReservationsVO;
import com.itwillbs.domain.ReviewsVO;
import com.itwillbs.mapper.AdminMapper;
import com.itwillbs.service.AdminService;
import com.mysql.cj.Session;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	private static final int List = 0;
	@Inject
	private	AdminMapper adminService;
	
	private void dashboardStats(Model model) {
	int userCount = adminService.getUserCount();
	int reviewsCount = adminService.getReviewsCount();
	int reservations = adminService.getReservationsCount();
	int inquiriesCount = adminService.getInquiriesCount();
	int movie_RequestsCount = adminService.getMovie_RequestsCount();
	
	model.addAttribute("userCount", userCount);
	model.addAttribute("reviewsCount", reviewsCount);
	model.addAttribute("reservations", reservations);
	model.addAttribute("inquiriesCount", inquiriesCount);
	model.addAttribute("movie_RequestsCount", movie_RequestsCount);

	}
		
	
	
	
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
			dashboardStats(model);
	
			return "/admin/dashboard";
		}
		
		// 영화 관리
		@GetMapping("/movie")
		public String movie(Model model) {
			dashboardStats(model);
			
			List<MovieVO> adminmovieList = adminService.AdminMovieList();
			model.addAttribute("adminmovieList", adminmovieList);
			return "/admin/movie";
		}
		
		@PostMapping("/movie/delete") 
		public String deleteMovie(@RequestParam("tmdbId") int tmdbId) {
		    

		    adminService.deleteMovie(tmdbId); 

		    return "redirect:/admin/movie"; 
		}
		
		// 사용자 관리
		@GetMapping("/users")
		public String users(Model model) {
			dashboardStats(model);
			
			List<MemberVO> adminuserList = adminService.AdminUserList();
			model.addAttribute("adminuserList", adminuserList);
			
			return "/admin/users";

		}
		
		@PostMapping("/users/delete") 
		public String deleteUsers(@RequestParam("user_id") String user_id) {
		    adminService.deleteUsers(user_id); 

		    return "redirect:/admin/users"; 
		}
		
		
		// 1:1 문의 관리
		@GetMapping("/inquiries")
		public String locationTerms(Model model) {
			dashboardStats(model);
					
		List<InquiriesVO> adminInquiriesList = adminService.AdminInquiriesList();
		model.addAttribute("adminInquiriesList", adminInquiriesList);
				
		return "/admin/inquiries";
		}
		
		@PostMapping("/inquiries/answer")
		public String answerInquiry(@RequestParam("id") int id, 
		                            @RequestParam("answerContent") String answerContent) {
		    
		    adminService.answerInquiry(id, answerContent); 
		    
		    return "redirect:/admin/inquiries";
		}
		
		@GetMapping("/inquiries/answerForm")
		public String answerForm(@RequestParam("id") int id, Model model) {
		    InquiriesVO inquiry = adminService.getInquiryDetail(id);
		    
		    model.addAttribute("inquiry", inquiry);
		    
		    return "/admin/inquiry_answer_form"; 
		}

		
		// 영화 요청
		@GetMapping("/movie_requests")
		public String movieRequests(Model model) {
			dashboardStats(model);
			
			List<MovieRequestVO> adminRequestList = adminService.AdminRequestList();
			model.addAttribute("adminRequestList", adminRequestList);
					
			return "/admin/movie_requests";
				}
				
//		@PostMapping("/movie_requests/delete") 
//		public String deleteMovieRequests(@RequestParam("userId") int userId) {
//		    
//
//		    adminService.deleteMovieRequests(userId); 
//
//		    return "/admin/movie_requests";
//		}
		
		
		
		
		// 리뷰 관리
		@GetMapping("/reviews")
		public String reviews(Model model) {
			dashboardStats(model);
			
			List<ReviewsVO> adminReviewsList = adminService.AdminReviewsList();
			model.addAttribute("adminReviewsList", adminReviewsList);
			
			return "/admin/reviews";
		}
		
		@PostMapping("/reviews/delete") 
		public String deletereviews(@RequestParam("id") int id) {
		    adminService.deleteReviews(id); 

		    return "redirect:/admin/reviews"; 
		}
		
		
		
		// 예매 관리
		@GetMapping("/reservations")
		public String reservations(Model model) {
			dashboardStats(model);
			List<ReservationsVO> adminReservationsList = adminService.AdminReservationsList();
			model.addAttribute("adminReservationsList", adminReservationsList);
			
			return "/admin/reservations";
		}

		@PostMapping("/reservations/refund")
		public String reservationsRefund(@RequestParam("id") int id){
		    adminService.AdminReservationsRefund(id); 
		    
		    return "redirect:/admin/reservations";
		}
		
		
		// 공지사항 관리
		@GetMapping("/notices")
		public String notice(Model model) {
			dashboardStats(model);
			return "/admin/notices";
		}
		
		// FAQ 관리
		@GetMapping("/faqs")
		public String faqs(Model model) {
			dashboardStats(model);
			return "/admin/faqs";
		}
	// ----------------------------------
		

	
	
}
