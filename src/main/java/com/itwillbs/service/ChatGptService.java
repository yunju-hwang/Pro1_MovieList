package com.itwillbs.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

@Service
public class ChatGptService {
	@Value("gpt.API_KEY")
	private String apiKey;
	
	private final String API_URL = "https://api.openai.com/v1/chat/completions";
	
	public String askGPT(List<String> reviews) {
		RestTemplate rest = new RestTemplate();
		
		String prompt = "다음 영화 리뷰들을 분석하고 요약, 감정, 추천 영화를 알려주세요:\n"
                + String.join("\n", reviews);
		
		// 요청 헤더 설정
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		headers.add("Authorization", "Bearer " + apiKey);
		
		// 요청 바디 설정
		Map<String, Object> body = new HashMap<>();
        body.put("model", "gpt-4o-mini");
        body.put("messages", List.of(Map.of("role", "user", "content", prompt)));
		
		HttpEntity<Map<String, Object>> entity = new HttpEntity<>(body, headers);
		
		// POST 요청
		ResponseEntity<Map> response = rest.postForEntity(API_URL, entity, Map.class);
		
		// 응답 파싱
		 List<Map<String, Object>> choices = (List<Map<String, Object>>) response.getBody().get("choices");
	     Map<String, Object> message = (Map<String, Object>) choices.get(0).get("message");
	     
	     
	     return (String) message.get("content");
		
		
	}

}
