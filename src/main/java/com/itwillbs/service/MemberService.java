package com.itwillbs.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.domain.GenresVO;
import com.itwillbs.domain.MemberVO;
import com.itwillbs.domain.UserGenresVO;
import com.itwillbs.mapper.MemberMapper;

@Service
public class MemberService {
	
//	@Autowired
//	private MemberMapper mapper; // MyBatis Mapper
	 
	 
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

	public void insertGenresList(List<UserGenresVO> userGenresList) {
	    if(userGenresList != null && !userGenresList.isEmpty()) {
	        // 반복문으로 하나씩 insert → MyBatis 다중 insert 문제 회피
	        for (UserGenresVO vo : userGenresList) {
	        	System.out.println("vo========" + vo);
	        	memberMapper.insertGenre(vo);
	        }
	    }
	}

	// 단일 insert용 메서드
	public void insertGenre(UserGenresVO vo) {
		memberMapper.insertGenre(vo);
	}
	

	
	
	
}

