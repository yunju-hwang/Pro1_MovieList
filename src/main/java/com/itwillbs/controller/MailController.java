package com.itwillbs.controller;

import javax.inject.Inject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.itwillbs.service.MailService; // MailService 주입

@Controller
public class MailController {

    // 🔗 MailService 주입 (SendGrid 통신 및 DB 조회/업데이트 담당)
    @Inject 
    private MailService mailService; 
    
    // =================================================================
    // 💡 1. 아이디 찾기 - 폼 화면 (GET 요청)
    // =================================================================
    @GetMapping("/findId")
    public String findIdForm() {
        // find_id.jsp와 매핑되는 뷰 경로를 반환합니다.
        return "/user/findId"; 
    }

    // 💡 2. 아이디 찾기 - 이메일 전송 처리 (POST 요청)
    @PostMapping("/findId/sendEmail")
    public String sendIdByEmail(@RequestParam("email") String userEmail, RedirectAttributes rttr) {
        
        // MailService에 DB 조회 및 이메일 발송 작업을 모두 위임
        boolean success = mailService.findIdAndSendEmail(userEmail); 
        
        if (success) {
        	rttr.addFlashAttribute("alertMsg", "아이디가 이메일로 전송되었습니다. 확인해 주세요.");
        } else {
            // 이메일이 DB에 없거나 발송에 실패한 경우
        	rttr.addFlashAttribute("alertMsg", "해당 이메일로 등록된 아이디가 없거나, 발송 중 오류가 발생했습니다.");
        }
        
        // 메시지를 담아 로그인 페이지로 리다이렉션
        return "redirect:/login"; 
    }
    
    // -----------------------------------------------------------------
    
    // =================================================================
    // 💡 3. 비밀번호 찾기 - 폼 화면 (GET 요청)
    // =================================================================
    @GetMapping("/findPw")
    public String findPwForm() {
        // find_pw.jsp와 매핑되는 뷰 경로를 반환합니다.
        return "/user/findPw"; 
    }
    
    // 💡 4. 비밀번호 찾기 - 임시 비밀번호 전송 처리 (POST 요청)
    @PostMapping("/findPw/sendEmail")
    public String sendPwByEmail(@RequestParam("userId") String userId, 
                                @RequestParam("email") String userEmail, 
                                RedirectAttributes rttr) {
        
        // MailService에 회원 확인, 임시 비밀번호 생성/업데이트, 이메일 발송 작업 위임
        boolean success = mailService.findPwAndSendEmail(userId, userEmail);
        
        if (success) {
        	rttr.addFlashAttribute("alertMsg", "임시 비밀번호가 이메일로 전송되었습니다. 확인 후 로그인해 주세요.");
        } else {
        	rttr.addFlashAttribute("alertMsg", "아이디 또는 이메일 정보가 일치하지 않거나, 발송 중 오류가 발생했습니다.");
        }
        
        // 메시지를 담아 로그인 페이지로 리다이렉션
        return "redirect:/login"; 
    }

}