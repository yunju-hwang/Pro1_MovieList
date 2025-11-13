package com.itwillbs.controller;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.itwillbs.domain.GenresVO;
import com.itwillbs.domain.MemberVO;
import com.itwillbs.service.AdminService;
import com.itwillbs.service.MemberService;

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

	@PostMapping("/register/step3Pro")
	public String step3Pro(List<Map<String, String>> genreList) {
		System.out.println(genreList);
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
	
	

