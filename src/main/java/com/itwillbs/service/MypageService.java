package com.itwillbs.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.mapper.MypageMapper;

@Service
public class MypageService {
	@Inject
	private MypageMapper mypageMapper; 
}
