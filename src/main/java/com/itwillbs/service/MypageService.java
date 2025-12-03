package com.itwillbs.service;

import java.util.HashMap;


import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.itwillbs.domain.InquiriesVO;
import com.itwillbs.domain.MemberVO;
import com.itwillbs.domain.TheatersVO;
import com.itwillbs.domain.UserFavoritesVO;
import com.itwillbs.domain.ReservationsVO;
import com.itwillbs.mapper.MypageMapper;

@Service
public class MypageService {
	@Inject
	private MypageMapper mypageMapper;

	public MemberVO getMember(String user_id) {
		return mypageMapper.getMember(user_id);
	}
	
	public int updateMember(MemberVO member) {
        return mypageMapper.updateMember(member);
    }
	
	public int updatePassword(String userId, String encryptedPassword) {
	    // Mapper로 사용자 ID와 암호화된 비밀번호를 전달합니다.
	    return mypageMapper.updatePassword(userId, encryptedPassword);
	}
	
	public int checkDuplicateNicknameForUpdate(MemberVO vo) {
        return mypageMapper.checkDuplicateNicknameForUpdate(vo);
    }
	
	public int checkDuplicateEmailForUpdate(MemberVO vo) {
        return mypageMapper.checkDuplicateEmailForUpdate(vo);
    }
	
	public int checkDuplicatePhoneForUpdate(MemberVO vo) {
        return mypageMapper.checkDuplicatePhoneForUpdate(vo);
    }
	
	@Transactional
	public boolean deleteMember(String userId) {
	    // Mapper를 호출하여 DB DELETE 구문을 실행합니다.
	    // DELETE 구문은 성공 시 1을 반환합니다.
	    int result = mypageMapper.deleteMember(userId);

	    // 삭제된 행의 수가 1 이상이면 true 반환
	    return result > 0;
	}

	public List<UserFavoritesVO> getFavoriteList(String userId) {
		
		return mypageMapper.selectFavoriteListByUserId(userId);
	}
	
	public int deleteFavoriteMovie(String userId, int tmdbId) {
		// Mapper에 사용자 ID와 영화 ID를 전달하여 삭제 요청
		return mypageMapper.deleteFavoriteMovie(userId, tmdbId);
	}
	
	public Map<Integer, List<String>> getMovieGenresMap(List<UserFavoritesVO> favoriteList) {
	    
	    Map<Integer, List<String>> genresMap = new HashMap<>(); 
	    
	    for (UserFavoritesVO movie : favoriteList) {
	        
	        // 💡 Mapper에 int 타입 그대로 전달
	        List<String> genres = mypageMapper.selectGenreNamesByTmdbId(movie.getTmdbId());
	        
	        // Map에 저장 (Key는 tmdbId, Value는 장르 이름 목록)
	        genresMap.put(movie.getTmdbId(), genres); 
	    }
	    return genresMap;
	}


	public List<TheatersVO> getTheaterList() {
		return mypageMapper.selectTheaterList();
	}
	
	// 📢 [수정] 메서드 이름 변경 및 isAjaxDelete 파라미터 추가
	@Transactional
	// 📢 [수정] isAjaxDelete 파라미터를 제거합니다. 이제 이 메서드는 '전체 갱신'만 담당합니다.
	public void processTheaterUpdate(String userId, List<Integer> selectedTheaterIds) { 
	    
	    // CASE: "선호 영화관 저장" 버튼 클릭 (폼 제출 전체 갱신)
	    
	    // 1. 기존 선호 영화관 정보 전체 삭제
	    mypageMapper.deleteUserTheaters(userId);

	    // 2. 새로 받은 목록이 비어있지 않은 경우에만 INSERT 실행
	    if (selectedTheaterIds != null && !selectedTheaterIds.isEmpty()) {
	        // Mapper 호출: 사용자 ID와 새로운 영화관 ID 목록을 전달
	        mypageMapper.insertUserTheaters(userId, selectedTheaterIds);
	    }
	    
	    // 📢 [삭제] isAjaxDelete 관련 if-else 로직 전체를 삭제했습니다.
	}
		
	    // 📢 [기존 메서드 삭제됨] saveUserTheaters는 Controller에서 processTheaterUpdate로 대체되었습니다.
	
	@Transactional
	public void deleteOneTheater(String userId, int theaterIdToDelete) {
	    // Mapper의 단일 삭제 메서드 직접 호출
	    mypageMapper.deleteOneUserTheater(userId, theaterIdToDelete);
	}
		
		public List<TheatersVO> searchTheatersByKeyword(String keyword) {
		 return mypageMapper.searchTheatersByKeyword(keyword);
		}
		
		public List<Integer> getSavedTheaterIds(String userId) {
		 return mypageMapper.selectUserTheaterIds(userId);
		}
		
		public List<ReservationsVO> selectReservationList(String userId) {
	        // Mapper의 getReservationList 쿼리를 호출합니다.
	        // 이 쿼리는 movies, theaters 테이블과 JOIN하여 모든 정보를 가져옵니다.
	        return mypageMapper.getReservationList(userId);
	    }
		
		public ReservationsVO selectReservationDetail(int reservationId) {
	        // Mapper의 getReservationDetail 쿼리를 호출합니다.
	        return mypageMapper.getReservationDetail(reservationId);
	    }
	
	
	

	
}