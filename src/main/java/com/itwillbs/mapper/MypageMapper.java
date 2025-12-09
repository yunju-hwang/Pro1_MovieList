	package com.itwillbs.mapper;
	
	import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
	import org.apache.ibatis.annotations.Param;
	
	import com.itwillbs.domain.InquiriesVO;
import com.itwillbs.domain.MemberVO;
	import com.itwillbs.domain.UserFavoritesVO;
	import com.itwillbs.domain.TheatersVO; 
	import com.itwillbs.domain.ReservationsVO;
	
	@Mapper
	public interface MypageMapper {
		
		public MemberVO getMember(String user_id);
		
		public MemberVO selectKakaoUserByUserId(String userId);
		
		public MemberVO selectNaverUserByUserId(String userId);
		
		int updateMember(MemberVO member);
		
		public int updatePassword(@Param("userId") String userId, @Param("password") String password);
		
		public int checkDuplicateNicknameForUpdate(MemberVO member);
		public int checkDuplicateEmailForUpdate(MemberVO member);
		public int checkDuplicatePhoneForUpdate(MemberVO member);
		
		public int deleteMember(String userId);
	
		public List<UserFavoritesVO> selectFavoriteListByUserId(String userId);
		
		public int deleteFavoriteMovie(@Param("userId") String userId, @Param("tmdbId") int tmdbId);
		
		/**
	     * 특정 영화 ID(tmdbId)에 해당하는 모든 장르 이름을 조회합니다.
	     * @param tmdbId 조회할 영화의 ID
	     * @return 장르 이름 목록 (List<String>)
	     */
	
		public List<String> selectGenreNamesByTmdbId(int tmdbId);
		
		public List<TheatersVO> selectTheaterList();
		
		void deleteUserTheaters(@Param("userId") String userId);
		
		void deleteOneUserTheater(@Param("userId") String userId, @Param("theaterId") int theaterId);
	    
	    /**
	     * 새로운 선호 영화관 목록을 user_theaters 테이블에 삽입합니다.
	     * @param userId 현재 사용자 ID
	     * @param theaterIds 삽입할 영화관 ID 목록
	     */
	    void insertUserTheaters(
	        @Param("userId") String userId, 
	        @Param("theaterIds") List<Integer> theaterIds
	    );
	    
	    List<TheatersVO> searchTheatersByKeyword(@Param("keyword") String keyword);
	    
	    List<Integer> selectUserTheaterIds(@Param("userId") String userId);
	    
	    public List<ReservationsVO> getReservationList(String userId);
	    
	    public ReservationsVO getReservationDetail(@Param("reservationId") int reservationId);
	    
	    int updateReservationStatus(Map<String, Object> params);
	
		
	}