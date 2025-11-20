package com.itwillbs.controller;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.itwillbs.domain.ReservationPaymentVO;
import com.itwillbs.service.PaymentService;

@RestController
@RequestMapping("/payment")
public class PaymentController {
	
	@Inject
	private PaymentService paymentService;
	
	
	// ------- 1) 아임포트 토큰 발급
    @GetMapping("/token")
    public ResponseEntity<String> getToken() {
        String token = paymentService.getToken();
        return ResponseEntity.ok(token);
    }
	
    // ------2) ️결제 완료 후 검증 & DB 저장
    @PostMapping("/verify")
    public ResponseEntity<Map<String,Object>> verifyPayment(@RequestBody ReservationPaymentVO vo ) {
        System.out.println("verify");
        Map<String,Object> response = new HashMap<>();
    	String result = paymentService.processPayment(vo);
        if (result.contains("성공")) {
        	response.put("success", true);
        } else {
        	response.put("success", false);
        }
        
        return ResponseEntity.ok(response);
    }
    
  

}
