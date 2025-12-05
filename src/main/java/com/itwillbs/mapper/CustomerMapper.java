package com.itwillbs.mapper;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.domain.FaqsVO;
import com.itwillbs.domain.InquiriesVO;
import com.itwillbs.domain.MovieRequestVO;
import com.itwillbs.domain.NoticesVO;

//interface로 구현
@Mapper
public interface CustomerMapper {

	int movie_request_count(String userId);

    void insertInquiry(InquiriesVO inq);

    List<InquiriesVO> inquiries(String userId);

    int inquiry_count(String userId);
    

 // 수정
    void updateInquiry(InquiriesVO inq);

    // 삭제
    void deleteInquiry(@Param("id") int id, @Param("userId") String userId);




    InquiriesVO inquiry_detail(int id);

  



	List<MovieRequestVO> movie_request(String userId);

	void insert_movie_request(MovieRequestVO movieRequestVO);
	
	MovieRequestVO movie_request_detail(int id);

	void update_movie_request(MovieRequestVO vo);

	void delete_movie_request(@Param("id") int id, @Param("userId") String userId);


    List<NoticesVO> notices();   // 전체 공지 목록
    NoticesVO notice_detail(int id);    // 공지 상세
    
    List<NoticesVO> getNoticesPaged(@Param("offset") int offset,
            @Param("pageSize") int pageSize);

	int getNoticesCount();

    List<FaqsVO> faqs();
    
    List<FaqsVO> getFaqsPaged(@Param("offset") int offset, @Param("pageSize") int pageSize);
    int getFaqsCount();








}