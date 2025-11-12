package com.itwillbs.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.domain.MemberVO;

//interface로 구현
@Mapper
public interface MypageMapper {
	
	/**
     * 회원 ID를 기반으로 회원 정보를 조회합니다.
     * @param user_id 조회할 회원의 ID
     * @return 조회된 회원 정보를 담는 MemberVO 객체
     */
    public MemberVO getMember(String user_id);
    
    // 이 메서드는 MypageMapper.xml 파일의 <select id="getMember"> 쿼리와 연결됩니다.

}
