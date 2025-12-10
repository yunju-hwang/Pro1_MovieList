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

    
    /* -------------------------------------
       📌 공지사항 내용 자동 줄바꿈 함수
    ------------------------------------- */
    private String cleanNoticeContent(String content) {
    	if (content == null) return "";


    	content = content.replace("\r\n", "\n");
    	StringBuilder result = new StringBuilder();
    	String[] lines = content.split("\n");


    	for (int i = 0; i < lines.length; i++) {
    	String line = lines[i].trim();


    	// "※" 단독 라인 → 다음 문장과 병합
    	if (line.equals("※") && i + 1 < lines.length) {
    	String next = lines[i + 1].trim();
    	result.append("※ ").append(next).append("\n");
    	i++;
    	} else {
    	result.append(lines[i]).append("\n");
    	}
    	}


    	return result.toString().trim();
    	}


    private String formatNoticeContent(String content) {
        if (content == null) return "";

        String result = content;

        result = result.replaceAll("[\\u2028\\u2029\\u00A0]", " ");
        result = result.replaceAll("[ ]{2,}", " ");
        result = result.replaceAll("(\\r?\\n\\s*){2,}", "\n");
        result = result.replaceAll("(?<=[.!?])\\s*", "\n");

        result = result.replaceAll("\\s*\\[(.*?)\\]\\s*", "\n\n[$1]\n");

        result = result.replaceAll("\\s*-\\s*", "\n- ");

        // ※ 병합된 뒤 → HTML <span> 적용
        result = result.replaceAll("※", "<span class='notice-mark'>※</span>");

        // ⭐ 여기 추가됨: ※ 앞에 무조건 한 줄 띄움
        result = result.replaceAll("(<br>)*<span class='notice-mark'>※</span>", "<br><span class='notice-mark'>※</span>");

        // 줄바꿈 <br> 변환
        result = result.replaceAll("\\r?\\n", "<br>");

        result = result.replaceAll("(<br>\\s*){3,}", "<br><br>");

        return result.trim();
    }





    	/* -------------------------------------
    	📌 공지사항 목록
    	------------------------------------- */
    	@GetMapping("/customer/notices")
    	public String notices(Model model, @RequestParam(value = "page", defaultValue = "1") int page) {


    	int pageSize = 5;
    	int offset = (page - 1) * pageSize;


    	List<NoticesVO> list = customerService.getNoticesPaged(offset, pageSize);


    	DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
    	List<Map<String, Object>> displayList = new ArrayList<>();


    	for (NoticesVO vo : list) {
    	Map<String, Object> map = new HashMap<>();
    	map.put("id", vo.getId());
    	map.put("title", vo.getTitle());
    	map.put("content", vo.getContent());
    	map.put("createdAt", vo.getCreatedAt() != null ? vo.getCreatedAt().format(formatter) : "-");
    	displayList.add(map);
    	}
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
    	if (notice == null) return "/error/404";


    	DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
    	String createdDate = notice.getCreatedAt() != null ? notice.getCreatedAt().format(formatter) : "-";


    	// 1) ※ 단독 문장 방지
    	String cleaned = cleanNoticeContent(notice.getContent());


    	// 2) 자동 줄바꿈 + HTML 변환
    	String formattedContent = formatNoticeContent(cleaned);


    	model.addAttribute("notice", notice);
    	model.addAttribute("createdDate", createdDate);
    	model.addAttribute("formattedContent", formattedContent);


    	return "/customer/notice_detail";
    	}




    /* -------------------------------------
       📌 FAQ
    ------------------------------------- */
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

        Object userId = session.getAttribute("userId");
        model.addAttribute("isLogin", userId != null);

        return "/customer/faqs";
    }




    /* -------------------------------------
       📌 1:1 문의내역
    ------------------------------------- */
    @GetMapping("/customer/inquiries")
    public String inquiries(HttpSession session, Model model,
                            @RequestParam(value="sort", required=false) String sort) {
        String userId = (String) session.getAttribute("user_id");
        if(userId == null) return "redirect:/member/login";

        List<InquiriesVO> inquiry_list = customerService.inquiries(userId);

        if(sort != null) {
            switch(sort) {
                case "date_desc": inquiry_list.sort((a,b) -> b.getCreatedAt().compareTo(a.getCreatedAt())); break;
                case "date_asc": inquiry_list.sort((a,b) -> a.getCreatedAt().compareTo(b.getCreatedAt())); break;
                case "pending": inquiry_list.sort((a,b) -> getStatusPriority(a.getStatus()) - getStatusPriority(b.getStatus())); break;
                case "completed": inquiry_list.sort((a,b) -> getStatusPriority(b.getStatus()) - getStatusPriority(a.getStatus())); break;
            }
        }

        int count = customerService.inquiry_count(userId);

        model.addAttribute("inquiry_list", inquiry_list);
        model.addAttribute("count", count);

        return "/customer/inquiries/inquiries";
    }

    private int getStatusPriority(String status) {
        return "pending".equals(status) ? 0 : 1;
    }


    @GetMapping("/customer/write_inquiry")
    public String write_inquiry(Model model) {
        model.addAttribute("mode", "write");
        model.addAttribute("inq", new InquiriesVO());
        return "customer/inquiries/write_inquiry";
    }


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
        return "customer/inquiries/write_inquiry";
    }



    @PostMapping("/customer/inquiry_update_pro")
    public String inquiry_update_pro(InquiriesVO inq, HttpSession session) {

        String userId = (String) session.getAttribute("user_id");
        if (userId == null) return "redirect:/member/login";

        inq.setUserId(userId);
        customerService.updateInquiry(inq);

        return "redirect:/customer/inquiries";
    }


    @GetMapping("/customer/inquiry_delete")
    public String inquiry_delete(@RequestParam("id") int id, HttpSession session) {

        String userId = (String) session.getAttribute("user_id");
        if (userId == null) return "redirect:/member/login";

        customerService.deleteInquiry(id, userId);

        return "redirect:/customer/inquiries";
    }



    @GetMapping("/customer/inquiries/inquiry_detail")
    public String inquiry_detail(@RequestParam("id") int id, Model model, HttpSession session) {

        String userId = (String) session.getAttribute("user_id");
        if (userId == null) return "redirect:/member/login";

        InquiriesVO vo = customerService.inquiry_detail(id);

        if (vo == null) {
            model.addAttribute("msg", "존재하지 않는 문의입니다.");
            model.addAttribute("url", "/customer/inquiries");
            return "redirect:/customer/inquiries";   // 🔥 여기 수정됨
        }

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

        String createdDate = vo.getCreatedAt().format(formatter);
        String answeredDate = vo.getAnsweredAt() != null ? vo.getAnsweredAt().format(formatter) : null;

        model.addAttribute("createdDate", createdDate);
        model.addAttribute("answeredDate", answeredDate);
        model.addAttribute("inq", vo);

        return "/customer/inquiries/inquiry_detail";   // ★ 이건 정상
    }





    /* -------------------------------------
       📌 영화 요청
    ------------------------------------- */
    @GetMapping("/customer/movie_request")
    public String movie_request(HttpSession session, Model model,
                                @RequestParam(value="sort", required=false) String sort) {
        String userId = (String) session.getAttribute("user_id");
        if(userId == null) return "redirect:/member/login";

        List<MovieRequestVO> list = customerService.movie_request(userId);

        if(sort != null) {
            switch(sort) {
                case "date_desc": list.sort((a,b) -> b.getCreatedAt().compareTo(a.getCreatedAt())); break;
                case "date_asc": list.sort((a,b) -> a.getCreatedAt().compareTo(b.getCreatedAt())); break;
                case "pending": list.sort((a,b) -> getStatusPriority(a.getStatus()) - getStatusPriority(b.getStatus())); break;
                case "completed": list.sort((a,b) -> getStatusPriority(b.getStatus()) - getStatusPriority(a.getStatus())); break;
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

        // 새 글 작성
        if (id == null) {
            model.addAttribute("mode", "write");
            model.addAttribute("movieRequest", new MovieRequestVO());
            return "/customer/movie_request/write_movie_request";
        }

        // 기존 수정
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



    @PostMapping("/customer/write_movie_request_pro")
    public String write_movie_request_pro(MovieRequestVO movieRequestVO, HttpSession session) {
        movieRequestVO.setUserId((String)session.getAttribute("user_id"));

        customerService.insert_movie_request(movieRequestVO);

        return "redirect:/customer/movie_request";
    }



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

        model.addAttribute("movieRequest", vo);
        model.addAttribute("createdAt", createdAt);
        model.addAttribute("processedAt", processedAt);

        return "/customer/movie_request/movie_request_detail";
    }



    // 약관 페이지
    @GetMapping("/terms")
    public String terms() {
        return "/terms/terms_of_service";
    }

    @GetMapping("/terms/policy")
    public String policy() {
        return "/terms/privacy_policy";
    }

    @GetMapping("/terms/youth")
    public String youth() {
        return "/terms/youth_policy";
    }

    @GetMapping("/terms/location")
    public String locationTerms() {
        return "/terms/location_terms";
    }

}
