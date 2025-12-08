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
import org.springframework.beans.factory.annotation.Autowired; 
import java.util.Map;


import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.itwillbs.domain.MemberVO;
import com.itwillbs.domain.NaverUserVO;
import com.itwillbs.mapper.MemberMapper;




@Service
public class NaverService {
	@Inject
	private MemberMapper memberMapper;
	
	@Autowired 
    private RestTemplate restTemplate;
	

    @Value("${naver.client.id}")
    private String naverClientId;
    
    @Value("${naver.client.secret}")
    private String naverClientSecret;

    @Value("${naver.redirect.uri}")
    private String naverRedirectUri;
    
    // access_token 받기
    public String getAccessToken(String code) {
    	RestTemplate rest = new RestTemplate();
    	
    	// header
    	HttpHeaders headers = new HttpHeaders();
    	headers.add("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");
    	
    	// body
        MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
        params.add("grant_type", "authorization_code");
        params.add("client_id", naverClientId);
        params.add("client_secret", naverClientSecret);
        params.add("redirect_uri", naverRedirectUri);
        params.add("code", code);
        
        HttpEntity<MultiValueMap<String, String>> request=
        		new HttpEntity<>(params, headers);
        
        ResponseEntity<String> response = rest.exchange(
        		"https://nid.naver.com/oauth2.0/token",
                HttpMethod.POST,
                request,
                String.class
                );
        
        JsonObject json = JsonParser.parseString(response.getBody()).getAsJsonObject();
        return json.get("access_token").getAsString();
        
    }
    

    // 사용자 정보 조회
    public NaverUserVO getUserInfo(String accessToken) {

        RestTemplate rt = new RestTemplate();

        HttpHeaders headers = new HttpHeaders();
        headers.add("Authorization", "Bearer " + accessToken);
        headers.add("Content-Type", "application/x-www-form-urlencoded;charset=utf-8");

        HttpEntity<MultiValueMap<String, String>> userInfoRequest =
                new HttpEntity<>(headers);

        ResponseEntity<String> response = rt.exchange(
                "https://openapi.naver.com/v1/nid/me",
                HttpMethod.POST,
                userInfoRequest,
                String.class
        );

        return new Gson().fromJson(response.getBody(), NaverUserVO.class);
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
    
    // 네이버 회원용 임시 비밀번호 생성
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
    public MemberVO loginOrSignup(String accessToken, NaverUserVO userInfo) {
    	String naverId = userInfo.getNaverId();
        System.out.println("네이버ID: " + naverId);

        // 1. 기존 회원 조회
        MemberVO memberVO = memberMapper.findBynaverId(naverId);

        if (memberVO == null) {
            // 신규 가입
            memberVO = new MemberVO();
            memberVO.setUser_id(generateUserId());
            memberVO.setPassword(generateTempPassword());
            memberVO.setNaverId(naverId);

            // 이메일
            String email = userInfo.getEmail();
            memberVO.setEmail(email);

            memberVO.setRole("user");

            // 닉네임
            String nickname = userInfo.getNickname();
            System.out.println("원래 닉네임: " + nickname);
            if (nickname == null || nickname.isEmpty()) {
                nickname = "NaverUser" + System.currentTimeMillis(); // 임시 닉네임
            }
            System.out.println("사용할 닉네임: " + nickname);
            memberVO.setNickname(nickname);
            memberVO.setUsername(nickname);

            // 프로필 이미지
            String profileImage = userInfo.getProfileImage();
            memberVO.setProfileImage(profileImage);
            
            memberVO.setNaver_access_token(accessToken);
            
            // 전화번호
            String phone = userInfo.getMobile();
            memberVO.setPhone(phone);
            
            // DB에 삽입
            memberMapper.insertnaverMember(memberVO);
        } else {
            System.out.println("이미 가입된 회원입니다: " + memberVO.getNickname());
            memberVO.setNaver_access_token(accessToken);
            memberMapper.updateAccessToken(memberVO);
        }
    	
    	return memberVO;
    	
    }
    
    public void naverLogout(String accessToken) {
        /*
         String naverLogoutUrl = "https://nid.naver.com/oauth2.0/token?grant_type=delete" +
                                "&client_id=" + naverClientId +
                                "&client_secret=" + naverClientSecret +
                                "&access_token=" + accessToken +
                                "&service_provider=NAVER";

        try {
        	restTemplate.getForObject(naverLogoutUrl, Map.class);
            System.out.println("네이버 Access Token 삭제 요청 완료.");
            
        } catch (Exception e) {
            System.err.println("네이버 Access Token 삭제 실패: " + e.getMessage());
        }
        */
    }
    
    
    
}
