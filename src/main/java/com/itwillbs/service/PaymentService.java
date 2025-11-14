package com.itwillbs.service;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.client.RestTemplate;

import com.itwillbs.domain.PaymentsVO;
import com.itwillbs.domain.ReservationPaymentVO;
import com.itwillbs.domain.ReservationsVO;
import com.itwillbs.mapper.PaymentMapper;

@Service
public class PaymentService {
	@Inject
	private PaymentMapper paymentMapper;
	// 아임포트 REST API Base URL
	private static final String IAMPORT_API_BASE_URL = "https://api.iamport.kr";
	
	// iamport key값
	@Value("${imp.api.key}")
	private String apiKey;
	// iamport secret key값
	@Value("${imp.api.secretkey}")
	private String secretKey;
	private String token;
	
	
	// restapi 통신을 위한 RestTemplate 불러오기
	private RestTemplate restTemplate = new RestTemplate();
	
	
	// 1) ---- iamport Access Token을 발급받는 메서드
	public String getToken() {
		String url = IAMPORT_API_BASE_URL+"/users/getToken";
		
		// 1. HTTP 헤더 설정 (Content-Type: application/json)
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		
		if (apiKey == null || secretKey == null) {
		       throw new IllegalStateException("Iamport API Key/Secret이 설정되지 않았습니다.");
		 }

		
		
		// 2. 요청 본문 (Body) 설정 -> KEY값들 넣기
		Map<String, String> body = new HashMap<>();
		body.put("imp_key", apiKey);
		body.put("imp_secret", secretKey);
		
		HttpEntity<Map<String, String>> entity = new HttpEntity<>(body, headers);
		
		// 3. api 호출해서 응답 받아오기 
		ResponseEntity<Map> response = restTemplate.postForEntity(url, entity, Map.class);
		Map responseBody = response.getBody();
		
		
        token = (String) ((Map) responseBody.get("response")).get("access_token");
        System.out.println(token);

        return token;
		
	}
	
	// 2) ---- 결제 검증 로직 
	public boolean verifyPayment(String impUid, BigDecimal expectedAmount, String token) {
		String url = IAMPORT_API_BASE_URL + "/payments/" + impUid;
		
		// 1. header 설정  (토큰값)
		HttpHeaders headers = new HttpHeaders();
		headers.set("Authorization", token);
		HttpEntity<String> entity = new HttpEntity<>(headers);
		
		// 2. API 호출 
		ResponseEntity<Map> response = restTemplate.exchange(url, HttpMethod.GET, entity, Map.class);
		Map responseBody = response.getBody();
		
		if(responseBody != null && responseBody.get("response") != null) {
			Map payment = (Map) responseBody.get("response");
			
			// 3. 실제 결제 금액 비교 
			String status = payment.get("status").toString();
			BigDecimal paidAmount = new BigDecimal(payment.get("amount").toString());
			
			 // 4. 금액이 맞으면 true
	        return status.equals("paid") && paidAmount.compareTo(expectedAmount) == 0;
			
		}
		
		return false;
		
	}
	
	// 3) --- 결제 검증 후 db 저장
	@Transactional
	public String processPayment(ReservationPaymentVO vo) {
		PaymentsVO payment = vo.getPayment();
		ReservationsVO reservation = vo.getReservation();
		
		// 1. 아임포트 토큰 발급
	    String token = getToken();
	    
	    // 2. 결제 검증 
		boolean isValid = verifyPayment(payment.getImpUid(), payment.getAmount(), token);
		
		if(isValid) {
			
			
			// 3-1. 예약 insert
			reservation.setStatus("reserved");
	        paymentMapper.insertReservation(reservation);
	        
	        // 3-2. 결제 테이블에 reservation_id 세팅 후 insert
	     	payment.setStatus("paid");
	     	payment.setReservationId(reservation.getId());
	     	paymentMapper.insertPayment(payment);
            
	        return "결제 완료 및 예약 성공";
		}else {
			 // 결제 실패
			return "결제 금액 불일치";
		}
	}
	
	
	
	
	
	
}
