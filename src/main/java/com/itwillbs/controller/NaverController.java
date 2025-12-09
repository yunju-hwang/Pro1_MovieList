package com.itwillbs.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.domain.MemberVO;
import com.itwillbs.domain.NaverUserVO;
import com.itwillbs.service.MemberService;
import com.itwillbs.service.NaverService;

@Controller
public class NaverController {

	@Inject
	private NaverService naverService; 
	
	@Inject
	private MemberService memberService;
	
	
	@GetMapping("/auth/naver/callback")
	public String naverCallback(@RequestParam("code")String code, HttpSession session) {
		String accessToken = naverService.getAccessToken(code);
		System.out.println(code);
	
		NaverUserVO user = naverService.getUserInfo(accessToken);
		System.out.println(accessToken);
		
		System.out.println(user);
		
		MemberVO loginUser = naverService.loginOrSignup(accessToken, user);
		

		session.setAttribute("loginUser", loginUser);
		
		return "redirect:/";
	}
	
}
