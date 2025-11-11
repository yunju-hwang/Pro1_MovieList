package com.itwillbs.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.domain.MemberVO;
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
}
