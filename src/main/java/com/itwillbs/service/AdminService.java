package com.itwillbs.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.domain.MemberVO;
import com.itwillbs.domain.MovieVO;
import com.itwillbs.mapper.AdminMapper;

@Service
public class AdminService {
	@Inject
	private AdminMapper adminMapper;
	
    public MemberVO loginAdmin(MemberVO loginVO) {
        
        MemberVO resultVO = adminMapper.loginAdmin(loginVO);

        return resultVO;
    }
	
    
    public int getUserCount() {
    	return adminMapper.getUserCount();
    }
    
    public int getReviewsCount() {
		return adminMapper.getReviewsCount();
    }
    
    public int getReservationsCount() {
    	return adminMapper.getReservationsCount();
    }
    
    
    public int getInquiriesCount() {
    	return adminMapper.getInquiriesCount();
    }
    
    public int getMovie_RequestsCount() {
    	return adminMapper.getMovie_RequestsCount();
    }
    
    public List<MovieVO> AdminMovieList(){
    	return adminMapper.AdminMovieList();
    }
    
}
