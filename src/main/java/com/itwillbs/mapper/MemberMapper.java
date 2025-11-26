package com.itwillbs.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.domain.GenresVO;
import com.itwillbs.domain.MemberVO;
import com.itwillbs.domain.UserGenresVO;

// interface로 구현
@Mapper
public interface MemberMapper {
	 // DB에서 아이디, 비밀번호 일치하는 회원 조회 (login)
    MemberVO loginMember(MemberVO member);
    
	void insertMember(MemberVO memberVO);

	List<GenresVO> getGenres();

	void insertGenresList(List<UserGenresVO> userGenresList);

	void insertGenre(UserGenresVO vo);

	MemberVO getMemberById(String user_id);

	int checkUserIdExists(String user_id); // 회원가입 ID 중복체크 메서드
	
}
