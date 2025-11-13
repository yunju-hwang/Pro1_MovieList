package com.itwillbs.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.itwillbs.domain.MemberVO;
import com.itwillbs.domain.UserFavoritesVO;
import com.itwillbs.mapper.MypageMapper;

@Service
public class MypageService {
	@Inject
	private MypageMapper mypageMapper; 
	
	/**
     * 회원 ID를 사용하여 DB에서 회원 정보를 조회합니다.
     * @param user_id 조회할 회원의 ID
     * @return 조회된 회원 정보 (MemberVO)
     */
    public MemberVO getMember(String user_id) {
        
        // Mapper의 getMember 메서드를 호출하여 DB 작업을 위임합니다.
        // 현재는 DB 수정 기능이 없으므로, 조회 기능만 남깁니다.
        return mypageMapper.getMember(user_id);
}
    /**
     * 🚨 특정 사용자의 찜한 영화 목록을 DB에서 조회합니다.
     * @param userId 조회할 회원의 ID
     * @return 찜한 영화 목록(UserFavoritesVO)의 List
     */
    public List<UserFavoritesVO> getFavoriteList(String userId) {
        // Mapper의 selectFavoriteListByUserId 메서드를 호출합니다.
        return mypageMapper.selectFavoriteListByUserId(userId);
    }
    
    
}
