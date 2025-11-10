package com.itwillbs.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.mapper.AdminMapper;

@Service
public class AdminService {
	@Inject
	private AdminMapper adminMapper;
}
