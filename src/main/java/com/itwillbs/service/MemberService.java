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
	
	// 로그인 처리
    public MemberVO loginMember(MemberVO member) {
        // DB에서 아이디와 비밀번호 일치 여부 확인
        // mapper에서 select 한 결과 반환
        return memberMapper.loginMember(member);
    }
    
    public void insertMember(MemberVO memberVO) {
		memberVO.setRole("user");
		memberMapper.insertMember(memberVO);
	}
	
	public List<GenresVO> getGenres() {
	
		System.out.println("MemberService getGenres()");
		return memberMapper.getGenres();
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
