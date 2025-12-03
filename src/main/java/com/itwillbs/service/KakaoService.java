package com.itwillbs.service;

import java.util.Random;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.RestTemplate;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.itwillbs.domain.KakaoUserVO;
import com.itwillbs.domain.MemberVO;
import com.itwillbs.mapper.MemberMapper;

@Service
public class KakaoService {
	@Inject
	private MemberMapper memberMapper;
	

    @Value("${kakao.restapi.key}")
    private String kakaoRestApiKey;

    @Value("${kakao.redirect.uri}")
    private String kakaoRedirectUri;
    
    
    // access_token 받기
    public String getAccessToken(String code) {
    	RestTemplate rest = new RestTemplate();
    	
    	// header
    	HttpHeaders headers = new HttpHeaders();
    	headers.add("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");
    	
    	// body
        MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
        params.add("grant_type", "authorization_code");
        params.add("client_id", kakaoRestApiKey);
        params.add("redirect_uri", kakaoRedirectUri);
        params.add("code", code);
        
        HttpEntity<MultiValueMap<String, String>> request=
        		new HttpEntity<>(params, headers);
        
        ResponseEntity<String> response = rest.exchange(
        		"https://kauth.kakao.com/oauth/token",
                HttpMethod.POST,
                request,
                String.class
                );
        
        JsonObject json = JsonParser.parseString(response.getBody()).getAsJsonObject();
        return json.get("access_token").getAsString();
        
    }
    
    
    // 사용자 정보 조회
    public KakaoUserVO getUserInfo(String accessToken) {

        RestTemplate rt = new RestTemplate();

        HttpHeaders headers = new HttpHeaders();
        headers.add("Authorization", "Bearer " + accessToken);
        headers.add("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");

        HttpEntity<MultiValueMap<String, String>> userInfoRequest =
                new HttpEntity<>(headers);

        ResponseEntity<String> response = rt.exchange(
                "https://kapi.kakao.com/v2/user/me",
                HttpMethod.POST,
                userInfoRequest,
                String.class
        );

        return new Gson().fromJson(response.getBody(), KakaoUserVO.class);
    }
    
    // user_id 생성
    public String generateUserId() {
    	int length = 8;
    	String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    	StringBuilder sb = new StringBuilder();
    	Random rnd = new Random();
    	
    	for(int i=0; i<length; i++) {
    		sb.append(chars.charAt(rnd.nextInt(chars.length())));
    	}
    	return sb.toString();
    }
    
    // kakao 회원용 임시 비밀번호 생성
    public String generateTempPassword() {
    	int length = 12;
    	String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    	StringBuilder sb = new StringBuilder();
    	Random rnd = new Random();
    	
    	for(int i=0; i<length; i++) {
    		sb.append(chars.charAt(rnd.nextInt(chars.length())));
    	}
    	return sb.toString();
    }
    
    
    
    // DB 처리
    @Transactional
    public MemberVO loginOrSignup(KakaoUserVO userInfo) {
    	Long kakaoId = userInfo.getKakaoId();
        System.out.println("카카오ID: " + kakaoId);

        // 1. 기존 회원 조회
        MemberVO memberVO = memberMapper.findBykakaoId(kakaoId);

        if (memberVO == null) {
            // 신규 가입
            memberVO = new MemberVO();
            memberVO.setUser_id(generateUserId());
            memberVO.setPassword(generateTempPassword());
            memberVO.setKakaoId(kakaoId);

            // 이메일
            String email = userInfo.getEmail();
            memberVO.setEmail(email);

            memberVO.setRole("user");

            // 닉네임
            String nickname = userInfo.getNickname();
            System.out.println("원래 닉네임: " + nickname);
            if (nickname == null || nickname.isEmpty()) {
                nickname = "KakaoUser" + System.currentTimeMillis(); // 임시 닉네임
            }
            System.out.println("사용할 닉네임: " + nickname);
            memberVO.setNickname(nickname);
            memberVO.setUsername(nickname);

            // 프로필 이미지
            String profileImage = userInfo.getProfileImageUrl();
            memberVO.setProfileImage(profileImage);

            // DB에 삽입
            memberMapper.insertkakaoMember(memberVO);
        } else {
            System.out.println("이미 가입된 회원입니다: " + memberVO.getNickname());
        }
    	
    	return memberVO;
    	
    }

    
}
