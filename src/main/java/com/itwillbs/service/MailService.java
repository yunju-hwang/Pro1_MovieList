package com.itwillbs.service;

import javax.inject.Inject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.nio.charset.Charset;
import java.util.Random; 

import com.itwillbs.mapper.MemberMapper; 
import com.itwillbs.domain.MemberVO; 

@Service
public class MailService {

    // 🔑 appdata.properties에서 Brevo API Key 주입
    // 🚨 @Value("${mail.API.key}") 변수 이름에 Brevo 키를 넣어주세요.
    @Value("${mail.API.key}") 
    private String brevoApiKey;
    
    // 🔗 MemberMapper를 직접 주입
    @Inject
    private MemberMapper memberMapper; 
    
    // 발신자 이메일 주소 (Brevo에서 인증된 주소여야 합니다!)
    private static final String FROM_EMAIL = "nkb0717@gmail.com"; 
    private static final String FROM_NAME = "MovieSite 관리자"; 

    // =================================================================
    // 💡 1. 아이디 찾기 - DB 조회 및 이메일 발송
    // =================================================================
    /**
     * 이메일 주소로 회원의 아이디를 찾고 이메일을 발송합니다.
     */
    public boolean findIdAndSendEmail(String userEmail) {
        
        String foundId = memberMapper.findIdByEmail(userEmail);
        
        if (foundId == null) {
            return false; 
        }
        
        String subject = "[MovieSite] 요청하신 아이디 정보입니다.";
        String contentText = 
            "<h2>[MovieSite] 회원 아이디 안내</h2>" +
            "<p>회원님의 아이디는 <b>" + foundId + "</b> 입니다.</p>" + 
            "<p>로그인 페이지로 돌아가 로그인해 주세요. 감사합니다.</p>";
            
        return sendEmail(userEmail, subject, contentText);
    }
    
    // =================================================================
    // 💡 2. 비밀번호 찾기 - 임시 비밀번호 생성 및 발송
    // =================================================================
    /**
     * ID와 Email로 회원을 확인하고 임시 비밀번호를 발급/발송합니다.
     */
    public boolean findPwAndSendEmail(String userId, String userEmail) {
        
        MemberVO member = memberMapper.getMemberByIdAndEmail(userId, userEmail);
        
        if (member == null) {
            return false; 
        }

        String tempPassword = generateRandomPassword(10);
        
        MemberVO updateMember = new MemberVO();
        updateMember.setUser_id(userId);
        
        // 🚨 [주의] 실제 서비스에서는 암호화(예: BCrypt)를 거쳐야 합니다.
        String encryptedPassword = tempPassword; 
        updateMember.setPassword(encryptedPassword); 
        
        int result = memberMapper.updateTemporaryPassword(updateMember);
        
        if (result == 0) {
            System.err.println("DEBUG: 임시 비밀번호 DB 업데이트 실패");
            return false;
        }

        String subject = "[MovieSite] 요청하신 임시 비밀번호입니다.";
        String contentText = 
            "<h2>[MovieSite] 임시 비밀번호 안내</h2>" +
            "<p>요청하신 회원님의 임시 비밀번호는 <b>" + tempPassword + "</b> 입니다.</p>" + 
            "<p>로그인 후 즉시 **비밀번호를 변경**해 주세요. 감사합니다.</p>";
            
        return sendEmail(userEmail, subject, contentText);
    }

    // =================================================================
    // 🔑 3. 유틸리티 메서드 (랜덤 비밀번호 생성)
    // =================================================================
    private String generateRandomPassword(int length) {
        String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        Random random = new Random();
        StringBuilder sb = new StringBuilder();
        
        for (int i = 0; i < length; i++) {
            sb.append(chars.charAt(random.nextInt(chars.length())));
        }
        return sb.toString();
    }
    

    // =================================================================
    // 📧 4. Brevo API를 통한 이메일 발송 핵심 로직 (RestTemplate 사용)
    // =================================================================
    /**
     * Brevo API (SMTP)를 통해 실제 이메일을 발송하는 내부 메서드
     */
    private boolean sendEmail(String toEmailAddress, String subject, String contentHtml) {
        
        RestTemplate rt = new RestTemplate();
        
        // 1. Header 설정 (Brevo는 'api-key' 헤더를 사용합니다)
        HttpHeaders headers = new HttpHeaders();
        headers.set("api-key", brevoApiKey);
        headers.setContentType(new MediaType("application", "json", Charset.forName("UTF-8")));
        
        // 🚨 Brevo API 키 디버그 출력 (401 오류 시 확인용)
        System.out.println("DEBUG: 사용되는 Brevo Key (앞 10자리): " + brevoApiKey.substring(0, Math.min(brevoApiKey.length(), 10)));
        System.out.println("DEBUG: 사용되는 Brevo Key (전체 길이): " + brevoApiKey.length());
        
        // 2. Body 설정 (JSON 형식)
        String jsonBody = String.format(
            "{" +
            "\"sender\": {\"name\":\"%s\", \"email\":\"%s\"}," +
            "\"to\": [{\"email\":\"%s\"}]," +
            "\"subject\":\"%s\"," +
            "\"htmlContent\":\"%s\"" +
            "}",
            FROM_NAME, FROM_EMAIL, 
            toEmailAddress, 
            // JSON 문자열 내부에 따옴표가 들어갈 경우 역슬래시 처리
            subject.replace("\"", "\\\""), 
            contentHtml.replace("\"", "\\\"") 
        );
        
        HttpEntity<String> request = new HttpEntity<>(jsonBody, headers);

        // 3. API 호출
        try {
            ResponseEntity<String> response = rt.exchange(
                "https://api.brevo.com/v3/smtp/email", // Brevo API 엔드포인트
                HttpMethod.POST,
                request,
                String.class
            );
            
            if (response.getStatusCode().is2xxSuccessful()) {
                System.out.println("✅ DEBUG: Brevo 이메일 발송 성공 (Status: " + response.getStatusCode() + ")");
                return true;
            } else {
                System.err.println("❌ DEBUG: Brevo 이메일 발송 실패 (Status: " + response.getStatusCode() + ")");
                System.err.println("❌ DEBUG: 응답 Body: " + response.getBody());
                return false;
            }

        } catch (Exception ex) {
            System.err.println("❌ DEBUG: Brevo API 통신 중 예외 발생");
            ex.printStackTrace();
            return false;
        }
    }
}