package com.itwillbs.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.domain.GenresVO;
import com.itwillbs.domain.MemberVO;
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
	
}
