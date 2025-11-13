package com.itwillbs.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.domain.MemberVO;
import com.itwillbs.domain.UserFavoritesVO;

//interface로 구현
@Mapper
public interface MypageMapper {
	
	/**
     * 회원 ID를 기반으로 회원 정보를 조회합니다.
     * @param user_id 조회할 회원의 ID
     * @return 조회된 회원 정보를 담는 MemberVO 객체
     */
    public MemberVO getMember(String user_id);
    
    // 이 메서드는 MypageMapper.xml 파일의 <select id="getMember"> 쿼리와 연결됩니다.
    /**
     * 🚨 특정 사용자의 찜한 영화 목록을 조회합니다.
     * @param userId 조회할 회원의 ID
     * @return 찜한 영화 목록(UserFavoritesVO)의 List
     */
    public List<UserFavoritesVO> selectFavoriteListByUserId(String userId);
    
    /**
     * TMDB ID를 기준으로 해당 영화의 모든 장르 이름을 조회
     * @param tmdbId 영화의 TMDB ID
     * @return 장르 이름(String) 목록
     */
    List<String> selectGenresByTmdbId(String tmdbId); // 🚨 이 메서드를 추가합니다.

}
