package com.itwillbs.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.domain.MemberVO;
import com.itwillbs.mapper.AdminMapper;

@Service
public class AdminService {
	@Inject
	private AdminMapper adminMapper;
	
    public MemberVO loginAdmin(MemberVO loginVO) {
        
        MemberVO resultVO = adminMapper.loginAdmin(loginVO);

        return resultVO;
    }
	
}
