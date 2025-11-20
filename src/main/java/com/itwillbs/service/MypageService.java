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
import com.itwillbs.mapper.MypageMapper;

@Service
public class MypageService {
	@Inject
	private MypageMapper mypageMapper;

	public MemberVO getMember(String user_id) {
		return mypageMapper.getMember(user_id);
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

	
}
