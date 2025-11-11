package com.itwillbs.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.domain.MemberVO;

// interface로 구현
@Mapper
public interface MemberMapper {
	 // DB에서 아이디, 비밀번호 일치하는 회원 조회 (login)
    MemberVO loginMember(MemberVO member);
}
