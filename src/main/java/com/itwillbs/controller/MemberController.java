package com.itwillbs.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

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
	
	// 회원가입 -> 선호 장르 선택
	@GetMapping("/register/step3")
	public String register3() {
		return "/user/register_step3";
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
	
	

