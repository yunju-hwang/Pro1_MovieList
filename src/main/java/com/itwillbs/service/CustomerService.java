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

    // 문의 리스트
    public List<InquiriesVO> inquiries(String userId) {
        return customerMapper.inquiries(userId);
    }

    // 문의 건수
    public int inquiry_count(String userId) {
        return customerMapper.inquiry_count(userId);
    }

    // 특정 문의 조회
    public InquiriesVO getInquiryById(int id) {
        return customerMapper.getInquiryById(id);
    }

    // 문의 삭제
    public void inquiry_delete(int id) {
        customerMapper.inquiry_delete(id);
    }

    // 문의 수정
    public void updateInquiry(InquiriesVO vo) {
        customerMapper.updateInquiry(vo);
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
	
	// 특정 영화 요청 조회
	public MovieRequestVO getMovieRequestById(int id) {
	    return customerMapper.getMovieRequestById(id);
	}

	// 영화 요청 수정
	public void updateMovieRequest(MovieRequestVO vo) {
	    customerMapper.updateMovieRequest(vo);
	}

	// 영화 요청 삭제
	public void movie_request_delete(int id) {
	    customerMapper.movie_request_delete(id);
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


	public MovieRequestVO getMovieRequestById(int id, String userId) {
	    MovieRequestVO vo = customerMapper.getMovieRequestById(id);
	    if(vo != null && vo.getUserId().equals(userId)) {
	        return vo;
	    }
	    return null;
	}

	






}

