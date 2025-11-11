package com.itwillbs.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.domain.MemberVO;
import com.itwillbs.domain.MovieVO;

//interface로 구현
@Mapper
public interface AdminMapper {

	MemberVO loginAdmin(MemberVO loginVO);

public	int getUserCount();


public int getReviewsCount();


public int getReservationsCount();

public int getInquiriesCount();

public int getMovie_RequestsCount();

public List<MovieVO> AdminMovieList();



}