package com.itwillbs.controller;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

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
	

		

	
	
}
