package com.itwillbs.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.mapper.CustomerMapper;

@Service
public class CustomerService {
	@Inject
	private CustomerMapper customerMapper;

}
