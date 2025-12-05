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
	public String notices(Model model, @RequestParam(value = "page", defaultValue = "1") int page) {

	    int pageSize = 5;
	    int offset = (page - 1) * pageSize;

	    // ✔ 원본 NoticeVO 리스트 가져오기
	    List<NoticesVO> list = customerService.getNoticesPaged(offset, pageSize);

	    // ✔ 날짜 포맷터
	    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

	    // ✔ JSP에서 쓰기 쉽게 가공한 리스트
	    List<Map<String, Object>> displayList = new ArrayList<>();

	    for (NoticesVO vo : list) {
	        Map<String, Object> map = new HashMap<>();
	        map.put("id", vo.getId());
	        map.put("title", vo.getTitle());
	        map.put("content", vo.getContent());

	        // 날짜 변환
	        map.put("createdAt", vo.getCreatedAt() != null
	                ? vo.getCreatedAt().format(formatter)
	                : "-");

	        displayList.add(map);
	    }

	    // ✔ 전체 공지 개수
	    int totalCount = customerService.getNoticesCount();
	    int totalPages = (int) Math.ceil((double) totalCount / pageSize);

	    model.addAttribute("list", displayList);
	    model.addAttribute("currentPage", page);
	    model.addAttribute("totalPages", totalPages);

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
	public String faqs(Model model,
	                   @RequestParam(value = "page", defaultValue = "1") int page,
	                   HttpSession session) {

	    int pageSize = 5;
	    int offset = (page - 1) * pageSize;

	    List<FaqsVO> list = customerService.getFaqsPaged(offset, pageSize);

	    int totalCount = customerService.getFaqsCount();
	    int totalPages = (int) Math.ceil((double) totalCount / pageSize);

	    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
	    List<Map<String, Object>> displayList = new ArrayList<>();

	    for (FaqsVO vo : list) {
	        Map<String, Object> map = new HashMap<>();
	        map.put("id", vo.getId());
	        map.put("question", vo.getQuestion());
	        map.put("answer", vo.getAnswer());
	        map.put("category", vo.getCategory());
	        map.put("createdAt", vo.getCreatedAt() != null ? vo.getCreatedAt().format(formatter) : "-");

	        displayList.add(map);
	    }

	    model.addAttribute("list", displayList);
	    model.addAttribute("currentPage", page);
	    model.addAttribute("totalPages", totalPages);

	    // ✅ 로그인 여부 JSP로 전달
	    Object userId = session.getAttribute("userId");
	    model.addAttribute("isLogin", userId != null);

	    return "/customer/faqs";
	}




	@GetMapping("/customer/inquiries")
    public String inquiries(HttpSession session, Model model,
                            @RequestParam(value="sort", required=false) String sort) {
        String userId = (String) session.getAttribute("user_id");
        if(userId == null) return "redirect:/member/login";

        List<InquiriesVO> inquiry_list = customerService.inquiries(userId);

        // 정렬 처리
        if(sort != null) {
            switch(sort) {
                case "date_desc":
                    inquiry_list.sort((a,b) -> b.getCreatedAt().compareTo(a.getCreatedAt()));
                    break;
                case "date_asc":
                    inquiry_list.sort((a,b) -> a.getCreatedAt().compareTo(b.getCreatedAt()));
                    break;
                case "pending":
                    // "답변대기" 먼저, "답변완료" 나중
                    inquiry_list.sort((a,b) -> getStatusPriority(a.getStatus()) - getStatusPriority(b.getStatus()));
                    break;
                case "completed":
                    // "답변완료" 먼저, "답변대기" 나중
                    inquiry_list.sort((a,b) -> getStatusPriority(b.getStatus()) - getStatusPriority(a.getStatus()));
                    break;
            }
            
        }

        
        int count = customerService.inquiry_count(userId);
        model.addAttribute("inquiry_list", inquiry_list);
        model.addAttribute("count", count);

        return "/customer/inquiries/inquiries";
    }
	
	// pending = 0, completed = 1
		private int getStatusPriority(String status) {
		    if("pending".equals(status)) return 0;
		    else return 1; // completed 또는 그 외
		}


	// 문의 작성 페이지
	@GetMapping("/customer/write_inquiry")
	public String write_inquiry(Model model) {
	    model.addAttribute("mode", "write");
	    model.addAttribute("inq", new InquiriesVO());
	    return "customer/inquiries/write_inquiry"; // ✔ 수정됨
	}
	
	// 문의 작성 처리
	@PostMapping("/customer/write_inquiry_pro")
	public String write_inquiry_pro(InquiriesVO inq, HttpSession session) {

	    String userId = (String) session.getAttribute("user_id");

	    if (userId == null) {
	        return "redirect:/member/login";
	    }

	    inq.setUserId(userId);
	    customerService.insertinquiry(inq);

	    return "redirect:/customer/inquiries";
	}


	// 문의 수정 페이지 (작성 폼 재사용)
	@GetMapping("/customer/inquiry_update")
	public String inquiry_update(@RequestParam("id") int id, Model model, HttpSession session) {

	    String userId = (String) session.getAttribute("user_id");
	    if (userId == null) return "redirect:/member/login";

	    InquiriesVO vo = customerService.inquiry_detail(id);

	    if (vo == null || !vo.getUserId().equals(userId)) {
	        model.addAttribute("msg", "수정 권한이 없습니다.");
	        model.addAttribute("url", "/customer/inquiries");
	        return "/error/redirect";
	    }

	    model.addAttribute("mode", "update");
	    model.addAttribute("inq", vo);
	    return "customer/inquiries/write_inquiry"; // ✔ 수정됨
	}



	// 문의 수정 처리
	@PostMapping("/customer/inquiry_update_pro")
	public String inquiry_update_pro(InquiriesVO inq, HttpSession session) {

	    String userId = (String) session.getAttribute("user_id");
	    if (userId == null) return "redirect:/member/login";

	    inq.setUserId(userId);
	    customerService.updateInquiry(inq);

	    return "redirect:/customer/inquiries";
	}


	// 문의 삭제 처리
	@GetMapping("/customer/inquiry_delete")
	public String inquiry_delete(@RequestParam("id") int id, HttpSession session) {

	    String userId = (String) session.getAttribute("user_id");
	    if (userId == null) return "redirect:/member/login";

	    customerService.deleteInquiry(id, userId);

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
	public String movie_request(HttpSession session, Model model,
	                            @RequestParam(value="sort", required=false) String sort) {
	    String userId = (String) session.getAttribute("user_id");
	    if(userId == null) return "redirect:/member/login";

	    List<MovieRequestVO> list = customerService.movie_request(userId);

	    // 정렬 처리
	    if(sort != null) {
	        switch(sort) {
	            case "date_desc":
	                list.sort((a,b) -> b.getCreatedAt().compareTo(a.getCreatedAt()));
	                break;
	            case "date_asc":
	                list.sort((a,b) -> a.getCreatedAt().compareTo(b.getCreatedAt()));
	                break;
	            case "pending":
	                list.sort((a,b) -> getStatusPriority(a.getStatus()) - getStatusPriority(b.getStatus()));
	                break;
	            case "completed":
	                list.sort((a,b) -> getStatusPriority(b.getStatus()) - getStatusPriority(a.getStatus()));
	                break;
	        }
	    }

	    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

	    List<Map<String,Object>> displayList = new ArrayList<>();
	    for(MovieRequestVO vo : list) {
	        Map<String,Object> map = new HashMap<>();
	        map.put("id", vo.getId());
	        map.put("title", vo.getTitle());
	        map.put("content", vo.getContent());
	        map.put("status", vo.getStatus());
	        map.put("createdAt", vo.getCreatedAt() != null ? vo.getCreatedAt().format(formatter) : "-");
	        displayList.add(map);
	    }

	    model.addAttribute("movie_request_list", displayList);
	    model.addAttribute("count", list.size());

	    return "/customer/movie_request/movie_request";
	}

	



    @GetMapping("/customer/write_movie_request")
    public String writeMovieRequest(@RequestParam(value = "id", required = false) Integer id,
                                    HttpSession session,
                                    Model model) {

        String userId = (String) session.getAttribute("user_id");
        if (userId == null) return "redirect:/member/login";

        // id가 없으면 작성 모드
        if (id == null) {
            model.addAttribute("mode", "write");
            model.addAttribute("movieRequest", new MovieRequestVO());
            return "/customer/movie_request/write_movie_request";
        }

        // id가 있으면 수정 모드
        MovieRequestVO vo = customerService.movie_request_detail(id);

        // 본인 요청인지 확인
        if (vo == null || !vo.getUserId().equals(userId)) {
            model.addAttribute("msg", "수정 권한이 없습니다.");
            model.addAttribute("url", "/customer/movie_request");
            return "/error/redirect";
        }

        model.addAttribute("mode", "update");
        model.addAttribute("movieRequest", vo);

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
	
	// 영화 요청 수정 페이지 (작성 페이지 재사용)
	@GetMapping("/customer/movie_request_update")
	public String movie_request_update(@RequestParam("id") int id, Model model, HttpSession session) {

	    String userId = (String) session.getAttribute("user_id");
	    if (userId == null) return "redirect:/member/login";

	    MovieRequestVO vo = customerService.movie_request_detail(id);

	    if (vo == null || !vo.getUserId().equals(userId)) {
	        model.addAttribute("msg", "수정 권한이 없습니다.");
	        model.addAttribute("url", "/customer/movie_request");
	        return "/error/redirect";
	    }

	    model.addAttribute("mode", "update");
	    model.addAttribute("movieRequest", vo);

	    return "/customer/movie_request/write_movie_request"; 
	}



	@PostMapping("/customer/movie_request_update_pro")
	public String movie_request_update_pro(MovieRequestVO vo, HttpSession session) {

	    String userId = (String) session.getAttribute("user_id");
	    if (userId == null) return "redirect:/member/login";

	    vo.setUserId(userId);
	    customerService.update_movie_request(vo);

	    return "redirect:/customer/movie_request";
	}


	
	
	


	// 영화 요청 삭제
	@GetMapping("/customer/movie_request_delete")
	public String movie_request_delete(@RequestParam("id") int id, HttpSession session) {

	    String userId = (String) session.getAttribute("user_id");
	    if (userId == null) return "redirect:/member/login";

	    customerService.delete_movie_request(id, userId);

	    return "redirect:/customer/movie_request";
	}



	@GetMapping("/customer/movie_request_detail")
	public String movie_request_detail(@RequestParam("id") int id, Model model, HttpSession session) {

	    String userId = (String) session.getAttribute("user_id");
	    if (userId == null) return "redirect:/member/login";

	    MovieRequestVO vo = customerService.movie_request_detail(id);
	    if (vo == null) {
	        model.addAttribute("msg", "존재하지 않는 요청입니다.");
	        model.addAttribute("url", "/customer/movie_request");
	        return "/error/redirect";
	    }

	    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

	    String createdAt = vo.getCreatedAt() != null ? vo.getCreatedAt().format(formatter) : "-";
	    String processedAt = vo.getProcessedAt() != null ? vo.getProcessedAt().format(formatter) : "-";

	    model.addAttribute("movieRequest", vo);   // JSP에서 movieRequest로 접근
	    model.addAttribute("createdAt", createdAt);
	    model.addAttribute("processedAt", processedAt);

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