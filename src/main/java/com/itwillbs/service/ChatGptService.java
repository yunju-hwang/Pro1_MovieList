package com.itwillbs.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.itwillbs.domain.UserReviewVO;

@Service
public class ChatGptService {
	@Value("${gpt.API_KEY}")
	private String apiKey;
	
	private final String API_URL = "https://api.openai.com/v1/chat/completions";
	
	
	
	
	
	// GPT에게 질문하기
	public String askGPT(String prompt) {	
		RestTemplate rest = new RestTemplate();
		System.out.println(apiKey);
        
		// 요청 헤더 설정
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		headers.add("Authorization", "Bearer " + apiKey);
		
		
		
		// 요청 바디 설정
		Map<String, Object> body = new HashMap<>();
        body.put("model", "gpt-4o-mini");
        body.put("messages", List.of(Map.of("role", "user", "content", prompt)));
		body.put("max_tokens", 1000); // 응답 최대 토큰 수 
		body.put("temperature", 0.7);
		
        
		HttpEntity<Map<String, Object>> entity = new HttpEntity<>(body, headers);
		
		
		// POST 요청
		ResponseEntity<Map> response = rest.postForEntity(API_URL, entity, Map.class);
		
		if (response.getBody() == null || !response.getBody().containsKey("choices")) {
            return "GPT 분석 실패: 응답이 없습니다.";
        }
		
		
		// 응답 파싱
		 List<Map<String, Object>> choices = (List<Map<String, Object>>) response.getBody().get("choices");
		 if (choices == null || choices.isEmpty()) return "GPT 분석 실패: 결과 없음";
		 
		 Map<String, Object> message = (Map<String, Object>) choices.get(0).get("message");
	     
	     
	     return (String) message.get("content");
		
		
	}

}
