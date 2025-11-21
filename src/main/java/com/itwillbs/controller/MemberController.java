package com.itwillbs.controller;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.itwillbs.domain.GenresVO;
import com.itwillbs.domain.MemberVO;

import com.itwillbs.domain.UserGenresVO;
import com.itwillbs.service.MemberService;

@Controller
public class MemberController {
	
	// MemberService 객체 생성

	@Inject
	private MemberService memberService;
	
	//로그인 페이지 이동
	@GetMapping("/login")
	public String login() {
		return "/user/login";
	}
	
	//회원가입 -> 약관동의
	@GetMapping("/register/step1")
	public String register1() {
		return "/user/register_step1";
	}
	
	// 회원가입 -> 정보입력
	@GetMapping("/register/step2")
	public String register2() {
		return "/user/register_step2";
	}
	
	//
	@PostMapping("/register/step2Pro")
//	public String step2Pro(MemberVO memberVO,HttpSession session,@RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate birthDate  ) {
	public String step2Pro(MemberVO memberVO,HttpSession session) {
		
		memberService.insertMember(memberVO);
		session.setAttribute("user_id", memberVO.getUser_id());
        session.setAttribute("role", memberVO.getRole());
        System.out.println(memberVO);
		return "redirect:/register/step3";
	}
	
	// 회원가입 -> ID 중복체크
	@RestController
	public class RegisterController {

	    @GetMapping("/register/idCheck")
	    public Map<String, Object> idCheck(@RequestParam String user_id) {
	        Map<String, Object> response = new HashMap<>();
	        boolean exists = memberService.checkUserIdExists(user_id); // 사용자 서비스에서 아이디 체크
	        response.put("exists", exists);
	        return response;
	    }
	}
	
	// 회원가입 -> 선호 장르 선택
	@GetMapping("/register/step3")
	public String register3(Model model) {
		List<GenresVO> genresVOList = memberService.getGenres();
		model.addAttribute("genresVOList", genresVOList);
		System.out.println(genresVOList);
		return "/user/register_step3";
	}
	
	 // 로그아웃
    @GetMapping("/member/logout")
    public String logout (HttpSession session) {
    	System.out.println("MemberController logout()");
        session.invalidate();
        return "redirect:/login";
    }
	
	//
	@PostMapping("/register/step3Pro")
	public String step3Pro(HttpServletRequest request, HttpSession session) {
	    String userId = (String) session.getAttribute("user_id");
	    String[] genreArray = request.getParameterValues("genre");

	    if (genreArray != null && genreArray.length > 0) {
	    	 List<UserGenresVO> userGenresList = new ArrayList<UserGenresVO>()	;
	    	 for(String genreId : genreArray) {
	    		 UserGenresVO vo = new UserGenresVO();
	    		 vo.setUserId(userId);
	    		 vo.setGenreId(Integer.parseInt(genreId)); 
	    	  	 userGenresList.add(vo);
	    	 }
	    	 
	   	
	        	System.out.println("userGenresList======"  + userGenresList);
	        // Service 호출
	        memberService.insertGenresList(userGenresList);
	    }

	    return "redirect:/login";
	}
	
// ------------------------------------------------
		
    
    // 로그인 POST 
    @PostMapping("/loginPro")
    public String loginPOST(MemberVO memberVO, HttpSession session, Model model) {
        
    	// 1.로그인 service -> db에서 로그인 결과값 받아오기 (일치하는 회원값)
        MemberVO resultVO = memberService.loginMember(memberVO); 
        
        
        // 2. 세션에 사용자 정보 저장 -> 나중에 role = admin이면 navbar 변경해 주셔야 합니다
        if (resultVO != null) {
            session.setAttribute("user_id", resultVO.getUser_id());
            session.setAttribute("role", resultVO.getRole());

            session.setAttribute("nickname", resultVO.getNickname());
          System.out.println(resultVO);

            
     
            // JSP에서 편하게 체크할 수 있도록 ${not empty sessionScope.loginUser} 체크
            session.setAttribute("loginUser", resultVO);
            if ("admin".equals(resultVO.getRole())) { // role이 'admin'이면
                return "redirect:/admin/dashboard"; // 관리자 대시보드로 이동
            } else {
            return "redirect:/main"; }
        } else {
            
        	// 로그인 실패 처리
            model.addAttribute("msg", "아이디 또는 비밀번호가 일치하지 않습니다."); // 실패 메시지 전달
            return "/user/login"; 
        }
    }
    

    
    
    
    
}
	



