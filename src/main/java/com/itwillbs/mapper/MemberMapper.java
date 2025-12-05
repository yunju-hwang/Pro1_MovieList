package com.itwillbs.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.itwillbs.domain.GenresVO;
import com.itwillbs.domain.MemberVO;
import com.itwillbs.domain.UserGenresVO;

// interface로 구현
@Mapper
public interface MemberMapper {
	 // DB에서 아이디, 비밀번호 일치하는 회원 조회 (login)
    MemberVO loginMember(MemberVO member);
    
	void insertMember(MemberVO memberVO);

	List<GenresVO> getGenres();

	void insertGenresList(List<UserGenresVO> userGenresList);

	void insertGenre(UserGenresVO vo);

	MemberVO getMemberById(String user_id);

	int checkUserIdExists(String user_id); // 회원가입 ID 중복체크 메서드
	
	boolean checkEmailExists(String email); //이메일 중복체크 메서드

	boolean checkPhoneExists(String phone); // 전화번호 중복체크 메서드
	
	int checkNicknameExists(String nickname); // 별명 중복 체크
	
	
	// 카카오용 login
	MemberVO findBykakaoId(Long kakaoId);
	
	// 카카오용 signup
	int insertkakaoMember(MemberVO memberVO);
	
	// mail용
    public String findIdByEmail(String email);
    
    // (선택적) 비밀번호 찾기 시 아이디와 이메일 일치 여부를 확인하는 메서드
    public MemberVO getMemberByIdAndEmail(
    		@Param("userId") String userId, 
            @Param("userEmail") String userEmail);
    
    public int updateTemporaryPassword(MemberVO updateMember);


	
}