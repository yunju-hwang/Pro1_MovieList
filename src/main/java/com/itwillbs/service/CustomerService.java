package com.itwillbs.service;

import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

import com.itwillbs.domain.FaqsVO;
import com.itwillbs.domain.InquiriesVO;
import com.itwillbs.domain.MovieRequestVO;
import com.itwillbs.domain.NoticesVO;
import com.itwillbs.mapper.CustomerMapper;

@Service
public class CustomerService {
	@Inject
	private CustomerMapper customerMapper;

	public void insertinquiry(InquiriesVO inquiriesVO) {
		inquiriesVO.setStatus("pending");
		inquiriesVO.setCreatedAt(LocalDateTime.now());
		customerMapper.insertinquirty(inquiriesVO);

	}

	public List<InquiriesVO> inquiries(String userId) {




		return customerMapper.inquiries(userId);
	}

	public int inquiry_count(String userId) {

		return customerMapper.inquiry_count(userId);
	}

	public InquiriesVO inquiry_update(int id) {
		return customerMapper.inquiry_update(id);
	}

	public void inquiry_delete(int id) {

		customerMapper.inquiry_delete(id);
	}


	   public InquiriesVO inquiry_detail(int id) {
	        return customerMapper.inquiry_detail(id);
	    }


	public List<MovieRequestVO> movie_request(String userId) {
		return customerMapper.movie_request(userId);
	}

	public int movie_request_count(String userId) {

		return customerMapper.movie_request_count(userId);
	}

	public void insert_movie_request(MovieRequestVO movieRequestVO) {
		movieRequestVO.setStatus("pending");
		movieRequestVO.setCreatedAt(LocalDateTime.now());

		customerMapper.insert_movie_request(movieRequestVO);

	}

    public List<NoticesVO> notices() {
        return customerMapper.notices();
    }

    public NoticesVO notice_detail(int id) {
        return customerMapper.notice_detail(id);
    }

	public List<FaqsVO> faqs() {
		return customerMapper.faqs();
	}








}

