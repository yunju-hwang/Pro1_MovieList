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


    public List<InquiriesVO> inquiries(String userId) {
        return customerMapper.inquiries(userId);
    }
    

    public int inquiry_count(String userId) {
        return customerMapper.inquiry_count(userId);
    }

    public void insertinquiry(InquiriesVO inq) {
        inq.setStatus("pending");
        inq.setCreatedAt(LocalDateTime.now());
        customerMapper.insertInquiry(inq);
    }
    public void updateInquiry(InquiriesVO inq) {
        customerMapper.updateInquiry(inq);
    }

    public void deleteInquiry(int id, String userId) {
        customerMapper.deleteInquiry(id, userId);
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
	
	public MovieRequestVO movie_request_detail(int id) {
	    return customerMapper.movie_request_detail(id);
	}

	public void update_movie_request(MovieRequestVO vo) {
	    customerMapper.update_movie_request(vo);
	}


	public void delete_movie_request(int id, String userId) {
	    customerMapper.delete_movie_request(id, userId);
	}


    public List<NoticesVO> notices() {
        return customerMapper.notices();
    }

    public NoticesVO notice_detail(int id) {
        return customerMapper.notice_detail(id);
    }
    
    public List<NoticesVO> getNoticesPaged(int offset, int pageSize) {
        return customerMapper.getNoticesPaged(offset, pageSize);
    }

    public int getNoticesCount() {
        return customerMapper.getNoticesCount();
    }
    
    

	public List<FaqsVO> faqs() {
		return customerMapper.faqs();
	}

	public List<FaqsVO> getFaqsPaged(int offset, int pageSize) {
	    return customerMapper.getFaqsPaged(offset, pageSize);
	}

	public int getFaqsCount() {
	    return customerMapper.getFaqsCount();
	}







}

