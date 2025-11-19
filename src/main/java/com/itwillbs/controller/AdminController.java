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

import com.itwillbs.domain.FaqsVO;
import com.itwillbs.domain.InquiriesVO;
import com.itwillbs.domain.MemberVO;
import com.itwillbs.domain.MovieRequestVO;
import com.itwillbs.domain.MovieVO;
import com.itwillbs.domain.NoticesVO;
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
	private AdminMapper adminService;

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

	// 관리자 대시보드
	@GetMapping("/dashboard")
	public String dashboard(HttpSession session, Model model) {
		dashboardStats(model);
		String userID = (String) session.getAttribute("user_id");
		String role = (String) session.getAttribute("role");
		if (userID == null || !"admin".equals(role)) {
			return "redirect:/login";
		}

		return "/admin/dashboard";
	}

	// 영화 관리
	@GetMapping("/movie")
	public String movie(HttpSession session, Model model) {
		dashboardStats(model);
		String userID = (String) session.getAttribute("user_id");
		String role = (String) session.getAttribute("role");
		if (userID == null || !"admin".equals(role)) {
			return "redirect:/login";
		}
		
		List<MovieVO> adminmovieList = adminService.AdminMovieList();
		model.addAttribute("adminmovieList", adminmovieList);
		return "/admin/movie";
	}

	@PostMapping("/movie/delete")
	public String deleteMovie(HttpSession session, @RequestParam("tmdbId") int tmdbId) {
		String userID = (String) session.getAttribute("user_id");
		String role = (String) session.getAttribute("role");
		if (userID == null || !"admin".equals(role)) {
			return "redirect:/login";
		}
		adminService.deleteMovie(tmdbId);

		return "redirect:/admin/movie";
	}

	// 사용자 관리
	@GetMapping("/users")
	public String users(HttpSession session, Model model) {
		dashboardStats(model);
		String userID = (String) session.getAttribute("user_id");
		String role = (String) session.getAttribute("role");
		if (userID == null || !"admin".equals(role)) {
			return "redirect:/login";
		}
		List<MemberVO> adminuserList = adminService.AdminUserList();
		model.addAttribute("adminuserList", adminuserList);

		return "/admin/users";

	}

	@PostMapping("/users/delete")
	public String deleteUsers(HttpSession session, @RequestParam("user_id") String user_id) {
		String userID = (String) session.getAttribute("user_id");
		String role = (String) session.getAttribute("role");
		if (userID == null || !"admin".equals(role)) {
			return "redirect:/login";
		}
		adminService.deleteUsers(user_id);

		return "redirect:/admin/users";
	}

	// 1:1 문의 관리
	@GetMapping("/inquiries")
	public String locationTerms(HttpSession session, Model model) {
		dashboardStats(model);
		String userID = (String) session.getAttribute("user_id");
		String role = (String) session.getAttribute("role");
		if (userID == null || !"admin".equals(role)) {
			return "redirect:/login";
		}
		List<InquiriesVO> adminInquiriesList = adminService.AdminInquiriesList();
		model.addAttribute("adminInquiriesList", adminInquiriesList);

		return "/admin/inquiries";
	}

	@PostMapping("/inquiries/answer")
	public String answerInquiry(HttpSession session, @RequestParam("id") int id, @RequestParam("answerContent") String answerContent) {
		String userID = (String) session.getAttribute("user_id");
		String role = (String) session.getAttribute("role");
		if (userID == null || !"admin".equals(role)) {
			return "redirect:/login";
		}
		adminService.answerInquiry(id, answerContent);

		return "redirect:/admin/inquiries";
	}

	@GetMapping("/inquiries/answerForm")
	public String answerForm(HttpSession session, @RequestParam("id") int id, Model model) {
		String userID = (String) session.getAttribute("user_id");
		String role = (String) session.getAttribute("role");
		if (userID == null || !"admin".equals(role)) {
			return "redirect:/login";
		}
		InquiriesVO inquiry = adminService.getInquiryDetail(id);
		model.addAttribute("inquiry", inquiry);

		return "/admin/inquiry_answer_form";
	}

	// 영화 요청
	@GetMapping("/movie_requests")
	public String movieRequests(HttpSession session, Model model) {
		dashboardStats(model);
		String userID = (String) session.getAttribute("user_id");
		String role = (String) session.getAttribute("role");
		if (userID == null || !"admin".equals(role)) {
			return "redirect:/login";
		}
		List<MovieRequestVO> adminRequestList = adminService.AdminRequestList();
		model.addAttribute("adminRequestList", adminRequestList);

		return "/admin/movie_requests";
	}

	@PostMapping("/movie_requests/update") 
	public String updateMovieRequests(HttpSession session, @RequestParam("id") int id) {
		String userID = (String) session.getAttribute("user_id");
		String role = (String) session.getAttribute("role");
		if (userID == null || !"admin".equals(role)) {
			return "redirect:/login";
		}
	    adminService.updateMovieRequests(id, "approved"); 

	    return "redirect:/admin/movie_requests";
	}

	
		@PostMapping("/movie_requests/delete") 
		public String deleteMovieRequests(HttpSession session, @RequestParam("id") int id) {
			String userID = (String) session.getAttribute("user_id");
			String role = (String) session.getAttribute("role");
			if (userID == null || !"admin".equals(role)) {
				return "redirect:/login";
			}
		    adminService.deleteMovieRequests(id); 

		    return "redirect:/admin/movie_requests";
		    
		}

	// 리뷰 관리
	@GetMapping("/reviews")
	public String reviews(HttpSession session, Model model) {
		dashboardStats(model);
		String userID = (String) session.getAttribute("user_id");
		String role = (String) session.getAttribute("role");
		if (userID == null || !"admin".equals(role)) {
			return "redirect:/login";
		}
		List<ReviewsVO> adminReviewsList = adminService.AdminReviewsList();
		model.addAttribute("adminReviewsList", adminReviewsList);

		return "/admin/reviews";
	}

	@PostMapping("/reviews/delete")
	public String deletereviews(HttpSession session, @RequestParam("id") int id) {
		String userID = (String) session.getAttribute("user_id");
		String role = (String) session.getAttribute("role");
		if (userID == null || !"admin".equals(role)) {
			return "redirect:/login";
		}
		adminService.deleteReviews(id);

		return "redirect:/admin/reviews";
	}

	// 예매 관리
	@GetMapping("/reservations")
	public String reservations(HttpSession session, Model model) {
		dashboardStats(model);
		String userID = (String) session.getAttribute("user_id");
		String role = (String) session.getAttribute("role");
		if (userID == null || !"admin".equals(role)) {
			return "redirect:/login";
		}
		List<ReservationsVO> adminReservationsList = adminService.AdminReservationsList();
		model.addAttribute("adminReservationsList", adminReservationsList);

		return "/admin/reservations";
	}

	@PostMapping("/reservations/refund")
	public String reservationsRefund(HttpSession session, @RequestParam("id") int id) {
		String userID = (String) session.getAttribute("user_id");
		String role = (String) session.getAttribute("role");
		if (userID == null || !"admin".equals(role)) {
			return "redirect:/login";
		}
		adminService.AdminReservationsRefund(id);

		return "redirect:/admin/reservations";
	}

	// FAQ 관리
	@GetMapping("/faqs")
	public String faqs(HttpSession session, Model model) {
		String userID = (String) session.getAttribute("user_id");
		String role = (String) session.getAttribute("role");
		if (userID == null || !"admin".equals(role)) {
			return "redirect:/login";
		}
		List<FaqsVO> adminFaqsList = adminService.AdminFaqsList();
		model.addAttribute("adminFaqsList", adminFaqsList);

		return "/admin/faqs";
	}

	@GetMapping("/faqs/write")
	public String faqWrite(HttpSession session) {
		String userID = (String) session.getAttribute("user_id");
		String role = (String) session.getAttribute("role");
		if (userID == null || !"admin".equals(role)) {
			return "redirect:/login";
		}
		return "/admin/faq_write_form";
	}

	@PostMapping("/faqs/write")
	public String faqWriteForm(HttpSession session, FaqsVO faqs) {
		String userID = (String) session.getAttribute("user_id");
		String role = (String) session.getAttribute("role");
		if (userID == null || !"admin".equals(role)) {
			return "redirect:/login";
		}
		adminService.AdminFaqsWrite(faqs);

		return "redirect:/admin/faqs";
	}

	@GetMapping("/faqs/update")
	public String FaqUpdate(HttpSession session, @RequestParam("id") int id, Model model) {
		String userID = (String) session.getAttribute("user_id");
		String role = (String) session.getAttribute("role");
		if (userID == null || !"admin".equals(role)) {
			return "redirect:/login";
		}
		FaqsVO faqs = adminService.getFaqsDetail(id);
		model.addAttribute("faqs", faqs);

		return "/admin/faq_update_form";
	}

	@PostMapping("/faqs/update")
	public String AdminFaqsUpdate(HttpSession session, FaqsVO faqs) {
		String userID = (String) session.getAttribute("user_id");
		String role = (String) session.getAttribute("role");
		if (userID == null || !"admin".equals(role)) {
			return "redirect:/login";
		}
		adminService.AdminFaqsUpdate(faqs);

		return "redirect:/admin/faqs";
	}

	@PostMapping("/faqs/delete")
	public String deleteFaqs(HttpSession session, @RequestParam("id") int id) {
		String userID = (String) session.getAttribute("user_id");
		String role = (String) session.getAttribute("role");
		if (userID == null || !"admin".equals(role)) {
			return "redirect:/login";
		}
		adminService.AdminFaqsDelete(id);

		return "redirect:/admin/faqs";
	}

	// 공지사항 관리
	@GetMapping("/notices")
	public String notice(HttpSession session, Model model) {
		String userID = (String) session.getAttribute("user_id");
		String role = (String) session.getAttribute("role");
		if (userID == null || !"admin".equals(role)) {
			return "redirect:/login";
		}
		List<NoticesVO> adminNoticesList = adminService.AdminNoticesList();
		model.addAttribute("adminNoticesList", adminNoticesList);

		return "/admin/notices";
	}

	@GetMapping("/notices/write")
	public String noticeWrite(HttpSession session) {
		String userID = (String) session.getAttribute("user_id");
		String role = (String) session.getAttribute("role");
		if (userID == null || !"admin".equals(role)) {
			return "redirect:/login";
		}
		return "/admin/notice_write_form";
	}

	@PostMapping("/notices/write")
	public String noticeWriteForm(HttpSession session, NoticesVO notices) {
		String userID = (String) session.getAttribute("user_id");
		String role = (String) session.getAttribute("role");
		if (userID == null || !"admin".equals(role)) {
			return "redirect:/login";
		}
		adminService.AdminNoticesWrite(notices);

		return "redirect:/admin/notices";
	}

	@GetMapping("/notices/update")
	public String noticeUpdate(HttpSession session, @RequestParam("id") int id, Model model) {
		String userID = (String) session.getAttribute("user_id");
		String role = (String) session.getAttribute("role");
		if (userID == null || !"admin".equals(role)) {
			return "redirect:/login";
		}
		NoticesVO notices = adminService.getNoticesDetail(id);
		model.addAttribute("notices", notices);

		return "/admin/notice_update_form";
	}

	@PostMapping("/notices/update")
	public String AdminNoticeUpdate(HttpSession session, NoticesVO notices) {
		String userID = (String) session.getAttribute("user_id");
		String role = (String) session.getAttribute("role");
		if (userID == null || !"admin".equals(role)) {
			return "redirect:/login";
		}
		adminService.AdminNoticesUpdate(notices);

		return "redirect:/admin/notices";
	}

	@PostMapping("/notices/delete")
	public String deleteNotice(HttpSession session, @RequestParam("id") int id) {
		String userID = (String) session.getAttribute("user_id");
		String role = (String) session.getAttribute("role");
		if (userID == null || !"admin".equals(role)) {
			return "redirect:/login";
		}
		adminService.AdminNoticesDelete(id);

		return "redirect:/admin/notices";
	}

	// ----------------------------------

}
