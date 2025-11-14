package com.itwillbs.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.domain.GenresVO;
import com.itwillbs.domain.MemberVO;
import com.itwillbs.domain.UserGenresVO;
import com.itwillbs.mapper.MemberMapper;

@Service
public class MemberService {
	@Inject
	private MemberMapper memberMapper;

	public void insertMember(MemberVO memberVO) {
		memberVO.setRole("user");
		memberMapper.insertMember(memberVO);
	}
	
	public List<GenresVO> getGenres() {
	
		System.out.println("MemberService getGenres()");
		return memberMapper.getGenres();
	}
	
	
	public MemberVO loginMember(MemberVO memberVO) {
		System.out.println("MemberService loginMember()");
		
		return memberMapper.loginMember(memberVO);
	}

	public void insertGenres(UserGenresVO userGenresVO) {
		System.out.println("MemberService insertGenres()");
		
		memberMapper.insertGenres(userGenresVO);
	}
	
	
	
	
	
}

