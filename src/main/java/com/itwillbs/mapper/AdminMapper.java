package com.itwillbs.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.domain.MemberVO;

//interface로 구현
@Mapper
public interface AdminMapper {

	MemberVO loginAdmin(MemberVO loginVO);

public	int getUserCount();


public int getReviewsCount();


public int getReservationsCount();

public int getInquieresCount();

public int getMovie_RequestsCount();






}