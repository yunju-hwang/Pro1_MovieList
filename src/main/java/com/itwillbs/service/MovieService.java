package com.itwillbs.service;


import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.mapper.MovieMapper;

@Service
public class MovieService {
	@Inject
	private MovieMapper movieMapper;
	
}
