package com.itwillbs.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.domain.KakaoUserVO;
import com.itwillbs.domain.MemberVO;
import com.itwillbs.service.KakaoService;
import com.itwillbs.service.MemberService;

@Controller
public class KakaoController {

	@Inject
	private KakaoService kakaoService; 
	
	@Inject
	private MemberService memberService;
	
	
	@GetMapping("/auth/kakao/callback")
	public String kakaoCallback(@RequestParam("code")String code, HttpSession session) {
		//1. access token 발급
		String accessToken = kakaoService.getAccessToken(code);
		
		//2. 사용자 정보 조회
		KakaoUserVO user = kakaoService.getUserInfo(accessToken);
		
		//3. db 로그인/회원가입
		MemberVO loginUser = kakaoService.loginOrSignup(user);
		
		//4. 세션 로그인 처리
		session.setAttribute("loginUser", loginUser);
		
		return "redirect:/";
	}
	
}
