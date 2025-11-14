package com.itwillbs.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.domain.GenresVO;
import com.itwillbs.domain.MemberVO;
import com.itwillbs.domain.UserGenresVO;

// interface로 구현
@Mapper
public interface MemberMapper {

	void insertMember(MemberVO memberVO);
	

	List<GenresVO> getGenres();


	public MemberVO loginMember(MemberVO memberVO);


	void insertGenres(UserGenresVO userGenresVO);
	
	
}
