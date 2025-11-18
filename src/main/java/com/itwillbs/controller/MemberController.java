package com.itwillbs.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.itwillbs.domain.GenresVO;
import com.itwillbs.domain.MemberVO;
import com.itwillbs.service.AdminService;
import com.itwillbs.service.MemberService;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors; // Java 8에서 collect(Collectors.toList()) 사용할 때 필요
//프로젝트 VO
import com.itwillbs.domain.UserGenresVO;


@Controller
public class MemberController {
	
	// MemberService 객체 생성
	@Inject
	private MemberService memberService;
	
	//로그인
	@GetMapping("/login")
	public String login() {
		return "/user/login";
	}
	

	
	// ====
	@PostMapping("/loginPro")
	public String loginPro(MemberVO memberVO, HttpSession session, Model model){
		System.out.println("MemberController loginPro()");
		
		MemberVO memberVO2 = memberService.loginMember(memberVO);
		if(memberVO2 != null) {
			session.setAttribute("loginUser", memberVO.getUser_id());
			return "redirect:/main";
		}else {
			model.addAttribute("msg", "아이디 또는 비밀번호가 일치하지 않습니다."); // 실패 메시지 전달
            return "/user/login"; 
			
		}
	}
	// ====
	
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
	public String step2Pro(MemberVO memberVO,HttpSession session) {
		memberService.insertMember(memberVO);
		session.setAttribute("user_id", memberVO.getUser_id());
        session.setAttribute("role", memberVO.getRole());
        System.out.println(memberVO);
		return "redirect:/register/step3";
	}
	
	
	
	// 회원가입 -> 선호 장르 선택
	@GetMapping("/register/step3")
	public String register3(Model model) {
		List<GenresVO> genresVOList = memberService.getGenres();
		model.addAttribute("genresVOList", genresVOList);
		System.out.println(genresVOList);
		return "/user/register_step3";
	}

//	===
//	@PostMapping("/register/step3Pro")
//	public String step3Pro(HttpServletRequest request, HttpSession session) {
//		String[] genreList = request.getParameterValues("genre");
//		System.out.println(Arrays.toString(genreList));
//		
//		//System.out.println(genreList[0]);
//		List<UserGenresVO> userGenresList = new ArrayList<UserGenresVO>();
//		
//		for (String genreId : genreList) {
//			UserGenresVO userGenresVO = new UserGenresVO();
//			userGenresVO.setUserId((String)session.getAttribute("user_id"));
//			userGenresVO.setGenreId(Integer.parseInt(genreId));
//			
//			memberService.insertGenres(userGenresVO);
//		}
//		
//		return "redirect:/login";
//	}
//	===

	
	@PostMapping("/register/step3Pro")
	public String step3Pro(HttpServletRequest request, HttpSession session) {
	    String userId = (String) session.getAttribute("user_id");
	    String[] genreArray = request.getParameterValues("genre");

	    if (genreArray != null && genreArray.length > 0) {
//	        List<UserGenresVO> userGenresList = Arrays.stream(genreArray)
//	                .map(Integer::parseInt)
//	                .map(genreId -> {
//	                    UserGenresVO vo = new UserGenresVO();
//	                    vo.setUserId(userId);
//	                    vo.setGenreId(genreId);
//	                    return vo;
//	                })
//	                .collect(Collectors.toList());
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

	
	// 로그아웃
	@GetMapping("/logout")
	public String logout (HttpSession session) {
		System.out.println("MemberController logout()");
	    session.invalidate();
	    return "redirect:/login";
	}
	
	
	
	 // STEP1: 약관 제출 처리
    @PostMapping("/step1")
    public String handleStep1(
            @RequestParam(value = "agreed_term1", required = false) String t1,
            @RequestParam(value = "agreed_term2", required = false) String t2,
            @RequestParam(value = "agreed_term3", required = false) String t3,
            HttpSession session,
            RedirectAttributes rt) {

        if (!"Y".equals(t1) || !"Y".equals(t2)) {
            rt.addFlashAttribute("error", "필수 약관에 모두 동의하셔야 합니다.");
            return "redirect:/register/step1";
        }

        session.setAttribute("REG_AGREED_TERMS", true);
        session.setAttribute("REG_AGREED_TERM1", t1);
        session.setAttribute("REG_AGREED_TERM2", t2);
        session.setAttribute("REG_AGREED_TERM3", t3);

        return "redirect:/register/step2";
    }

  
	
// ------------------------------------------------
		
    @Inject
    private AdminService adminService; 
    
    @PostMapping("/login")
    public String loginPOST(MemberVO loginVO, HttpSession session, Model model) {
        

        MemberVO resultVO = adminService.loginAdmin(loginVO); 
        
        if (resultVO != null) {
            session.setAttribute("user_id", resultVO.getUser_id());
            session.setAttribute("role", "admin");
            
            return "redirect:/admin/dashboard"; 
            
        } else {

            // TODO: (다음 할 일) 일반 사용자 로그인 Service 호출 로직 추가
            

            model.addAttribute("msg", "아이디 또는 비밀번호가 일치하지 않습니다."); // 실패 메시지 전달
            return "/user/login"; 
        }
    }
}
	
	

