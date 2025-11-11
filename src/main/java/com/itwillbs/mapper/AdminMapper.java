package com.itwillbs.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.domain.MemberVO;
import com.itwillbs.domain.MovieVO;

//interface로 구현
@Mapper
public interface AdminMapper {

	MemberVO loginAdmin(MemberVO loginVO);

	
//대쉬보드 
public	int getUserCount();

public int getReviewsCount();

public int getReservationsCount();

public int getInquiriesCount();

public int getMovie_RequestsCount();


//영화관리
public List<MovieVO> AdminMovieList();

public int deleteMovie(int tmdbId);

//사용자 관리
public List<MemberVO> AdminUserList();

public int deleteUsers(String user_id);



}