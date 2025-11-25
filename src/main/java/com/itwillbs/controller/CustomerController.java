package com.itwillbs.controller;

import java.sql.Date;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.domain.FaqsVO;
import com.itwillbs.domain.InquiriesVO;
import com.itwillbs.domain.MovieRequestVO;
import com.itwillbs.domain.NoticesVO;
import com.itwillbs.service.CustomerService;

@Controller
public class CustomerController {

	@Inject
	private CustomerService customerService;

	// 고객센터 공지사항
	@GetMapping("/customer/notices")
	public String notices(Model model) {

	    // ✔ DB에서 받아온 리스트
	    List<NoticesVO> list = customerService.notices();

	    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

	    // ✔ 출력용 리스트
	    List<Map<String, Object>> displayList = new ArrayList<>();

	    for (NoticesVO vo : list) {
	        Map<String, Object> map = new HashMap<>();
	        map.put("id", vo.getId());
	        map.put("title", vo.getTitle());
	        map.put("content", vo.getContent());

	        // ★ createdAt 날짜를 yyyy-MM-dd 로 변환
	        map.put("createdAt", vo.getCreatedAt().format(formatter));

	        displayList.add(map);
	    }

	    model.addAttribute("list", displayList);

	    return "/customer/notices";
	}

	@GetMapping("/customer/notice_detail")
	public String notice_detail(@RequestParam("id") int id, Model model) {

	    NoticesVO notice = customerService.notice_detail(id);
	    if(notice == null) {
	        // 공지가 없으면 404 페이지나 기본 메시지
	        return "/error/404";
	    }

	    String createdDate = "";
	    if(notice.getCreatedAt() != null) {
	        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
	        createdDate = notice.getCreatedAt().format(formatter);
	    }

	    model.addAttribute("notice", notice);
	    model.addAttribute("createdDate", createdDate);

	    return "/customer/notice_detail";
	}
	

	@GetMapping("/customer/faqs")
	public String faqs(Model model) {
	    List<FaqsVO> list = customerService.faqs();

	    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
	    List<Map<String, Object>> displayList = new ArrayList<>();

	    for (FaqsVO vo : list) {
	        Map<String, Object> map = new HashMap<>();
	        map.put("id", vo.getId());
	        map.put("question", vo.getQuestion());
	        map.put("answer", vo.getAnswer());
	        map.put("createdAt", vo.getCreatedAt().format(formatter));
	        map.put("category", vo.getCategory());
	        displayList.add(map);
	    }

	    model.addAttribute("list", displayList);
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
	public String inquiry_detail(@RequestParam("id") int id, Model model,HttpSession session) {

	    // 1. 로그인 체크
	    String userId = (String) session.getAttribute("user_id");
	    System.out.println(userId);
	    if (userId == null) {
	        // 로그인 안 되었으면 로그인 페이지로 리다이렉트
	        return "redirect:/member/login";
	    }

	    // 2. DB에서 문의사항 가져오기
	    InquiriesVO vo = customerService.inquiry_detail(id);

	    if (vo == null) {
	        // id가 없는 경우 404 대신 간단히 메세지 페이지로 이동
	        model.addAttribute("msg", "존재하지 않는 문의입니다.");
	        model.addAttribute("url", "/customer/inquiries");
	        return "redirect"; // redirect.jsp 필요
	    }
	    
	    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

	 // 작성일 변환
	 String createdDate = vo.getCreatedAt().format(formatter);

	 // 답변일 변환 (null 체크)
	 String answeredDate = null;
	 if (vo.getAnsweredAt() != null) {
	     answeredDate = vo.getAnsweredAt().format(formatter);
	 }

	 model.addAttribute("createdDate", createdDate);
	 model.addAttribute("answeredDate", answeredDate);

	    // 3. Model에 데이터 담기
	    model.addAttribute("inq", vo);

	    // 4. JSP 이름 반환 (redirect 제거!)
	    return "customer/inquiries/inquiry_detail";
	}

    @GetMapping("/customer/movie_request")
    public String movie_request(HttpSession session, Model model) {
        String userId = (String) session.getAttribute("user_id");

        // DB에서 VO 리스트 가져오기
        List<MovieRequestVO> list = customerService.movie_request(userId);

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

        // 출력용 Map 리스트 생성
        List<Map<String, Object>> displayList = new ArrayList<>();

        for (MovieRequestVO vo : list) {
            Map<String, Object> map = new HashMap<>();
            map.put("id", vo.getId());
            map.put("title", vo.getTitle());
            map.put("content", vo.getContent());
            map.put("status", vo.getStatus());

            // createdAt 날짜를 yyyy-MM-dd로 변환
            map.put("createdAt", vo.getCreatedAt() != null ? vo.getCreatedAt().format(formatter) : "-");

            displayList.add(map);
        }
        
        System.out.println(list);

        model.addAttribute("movie_request_list", displayList);
        model.addAttribute("count", list.size());

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
		customerService.insert_movie_request(movieRequestVO);


		return "redirect:/customer/movie_request";
	}
	
	@GetMapping("/customer/movie_request_detail")
	public String movie_request_detail() {
		
		return "/customer/movie_request/movie_request_detail";
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