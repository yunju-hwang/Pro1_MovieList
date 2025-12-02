package com.itwillbs.domain;

import java.time.LocalDate;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MemberVO {

	private String user_id; //id값
	private String role; // admin, 일반회원 구분
	private String password;  // 비밀번호
	private String username; // 이름
	private String email; // 이메일
	private String gender; // 성별
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private LocalDate birthDate; // 생일(생년월일만 다루기 위해 LocalDate 사용)
	private String phone; // 전화번호
	private String profileImage; // 프로필 사진 경로 저장
	private String nickname; //id값
	private Long kakaoId; // kakao 추가
	
	
	private LocalDate createdAt;      // 가입일 (DB에 created_at이 있다면)
    private LocalDate lastLogin;      // 최근 접속일 (DB에 last_login이 있다면)
    private Integer reviewCount;      // 리뷰 건수
    private Integer reservationCount; // 예매 건수
    private Integer inquiryCount;     // 문의 건수
    private Integer movieRequestCount; // 영화 요청 건수
	
	
	
}