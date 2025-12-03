package com.itwillbs.controller;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itwillbs.domain.GenresVO;
import com.itwillbs.domain.MemberVO;
import com.itwillbs.domain.UserGenresVO;
import com.itwillbs.service.MemberService;

@Controller
public class MemberController {

	// MemberService 객체 생성
	@Inject
	private MemberService memberService;

	@Value("${kakao.restapi.key}")
	private String kakaoClientId;

	@Value("${kakao.redirect.uri}")
	private String kakaoRedirectUri;

	// 로그인 페이지 이동
	@GetMapping("/login")
	public String login(Model model) {
		model.addAttribute("kakaoClientId", kakaoClientId);
		model.addAttribute("kakaoRedirectUri", kakaoRedirectUri);
		return "/user/login";
	}

	// 1단계
	// 회원가입 -> 약관동의
	@GetMapping("/register/step1")
	public String register1() {
		return "/user/register_step1";
	}

	// 이용약관 보기
	@GetMapping("/terms/service")
	public String viewTermsService() {
		return "user/terms_of_service"; // /WEB-INF/views/terms_of_service.jsp
	}

	// 개인정보 처리방침 보기
	@GetMapping("/terms/privacy")
	public String viewPrivacyPolicy() {
		return "user/privacy_policy"; // /WEB-INF/views/privacy_policy.jsp
	}

	// 마케팅 정보 수신 동의 보기
	@GetMapping("/terms/marketing")
	public String viewMarketingConsent() {
		return "user/marketing_consent"; // /WEB-INF/views/marketing_consent.jsp
	}

	// 회원가입 -> 정보입력
	@PostMapping("/register/step2")
	public String step1Pro(HttpServletRequest request, HttpSession session, Model model) {
		session.setAttribute("termsAgree", request.getParameter("agree_terms"));
		session.setAttribute("privacyAgree", request.getParameter("agree_privacy"));
		String agree_marketing = request.getParameter("agree_marketing");
		if (request.getParameter("agree_marketing") == null) {
			agree_marketing = "";
		}
		session.setAttribute("marketingAgree", agree_marketing);

		System.out.println("리퀘스트값 " + agree_marketing);

		model.addAttribute("termsAgree", session.getAttribute("termsAgree"));
		model.addAttribute("privacyAgree", session.getAttribute("privacyAgree"));
		model.addAttribute("marketingAgree", session.getAttribute("marketingAgree"));

		return "/user/register_step2";
	}

	//

	// 2단계: 회원정보 입력 (DB 저장 X, 세션 저장)
	@PostMapping("/register/step2Pro")
	public String step2Pro(HttpServletRequest request, HttpSession session, Model model) {
		// 필수 폼 값 가져오기
		String userId = request.getParameter("user_id");
		String password = request.getParameter("password");
		String username = request.getParameter("username");
		String nickname = request.getParameter("nickname");
		String email = request.getParameter("email");
		String gender = request.getParameter("gender");
		String birthDate = request.getParameter("birthDate");
		String phone = request.getParameter("phone");

		// 필수 체크
		if (userId == null || userId.isEmpty() || password == null || password.isEmpty() || username == null
				|| username.isEmpty() || nickname == null || nickname.isEmpty() || email == null || email.isEmpty()
				|| gender == null || gender.isEmpty() || birthDate == null || birthDate.isEmpty() || phone == null
				|| phone.isEmpty()) {
			model.addAttribute("msg", "모든 필수 항목을 입력해주세요.");
			model.addAttribute("user_id", userId);
			model.addAttribute("username", username);
			model.addAttribute("nickname", nickname);
			model.addAttribute("email", email);
			model.addAttribute("gender", gender);
			model.addAttribute("birthDate", birthDate);
			model.addAttribute("phone", phone);
			return "/user/register_step2";
		}

		// 세션 저장
		session.setAttribute("user_id", userId);
		session.setAttribute("password", password);
		session.setAttribute("username", username);
		session.setAttribute("nickname", nickname);
		session.setAttribute("email", email);
		session.setAttribute("gender", gender);
		session.setAttribute("birthDate", birthDate);
		session.setAttribute("phone", phone);

		// ✅ 체크박스 boolean 변환 후 세션 저장
		session.setAttribute("termsAgree", "agree_terms".equals(session.getAttribute("termsAgree")));
		session.setAttribute("privacyAgree", "agree_privacy".equals(session.getAttribute("privacyAgree")));
		session.setAttribute("marketingAgree", "agree_marketing".equals(session.getAttribute("marketingAgree")));

		return "redirect:/register/step3";
	}

	// 3단계: 선호 장르 선택
	@GetMapping("/register/step3")
	public String registerStep3(Model model) {
		List<GenresVO> genresVOList = memberService.getGenres();
		model.addAttribute("genresVOList", genresVOList);
		return "/user/register_step3";
	}

	//

	@PostMapping("/register/step3Pro")
	public String step3Pro(HttpServletRequest request, HttpSession session, Model model) {
		// 1. 세션에서 값 가져오기
		MemberVO memberVO = new MemberVO();
		memberVO.setUser_id((String) session.getAttribute("user_id"));
		memberVO.setPassword((String) session.getAttribute("password"));
		memberVO.setUsername((String) session.getAttribute("username"));
		memberVO.setNickname((String) session.getAttribute("nickname"));
		memberVO.setEmail((String) session.getAttribute("email"));
		memberVO.setGender((String) session.getAttribute("gender"));
		memberVO.setPhone((String) session.getAttribute("phone"));

		// 생년월일 처리
		String birthDateStr = (String) session.getAttribute("birthDate");
		if (birthDateStr != null && !birthDateStr.isEmpty()) {
			memberVO.setBirthDate(LocalDate.parse(birthDateStr));
		}

		// 약관 처리
		memberVO.setTermsAgree(Boolean.TRUE.equals(session.getAttribute("termsAgree")));
		memberVO.setPrivacyAgree(Boolean.TRUE.equals(session.getAttribute("privacyAgree")));
		memberVO.setMarketingAgree(Boolean.TRUE.equals(session.getAttribute("marketingAgree")));

		memberVO.setRole("user");

		// DB 저장
		memberService.insertMember(memberVO);

		// 선호 장르 저장
		String[] genres = request.getParameterValues("genre");
		if (genres != null && genres.length > 0) {
			List<UserGenresVO> userGenresList = new ArrayList<>();
			for (String genreId : genres) {
				UserGenresVO vo = new UserGenresVO();
				vo.setUserId(memberVO.getUser_id());
				vo.setGenreId(Integer.parseInt(genreId));
				userGenresList.add(vo);
			}
			memberService.insertGenresList(userGenresList);
		}

		// ✅ JSP에서 모달 띄우기 위해 Model에 속성 전달
		model.addAttribute("signupSuccess", true);

		// redirect하지 않고 JSP 그대로 포워딩
		List<GenresVO> genresVOList = memberService.getGenres();
		model.addAttribute("genresVOList", genresVOList);

		return "/user/register_step3";
	}

	// ID 중복 체크
	@ResponseBody
	@GetMapping("/register/idCheck")
	public boolean idCheck(@RequestParam String user_id) {
		return memberService.checkUserIdExists(user_id);
	}

	// 이메일 중복 체크
	@ResponseBody
	@GetMapping("/register/emailCheck")
	public boolean emailCheck(@RequestParam String email) {
		return memberService.checkEmailExists(email);
	}

	// 전화번호 중복 체크
	@ResponseBody
	@GetMapping("/register/phoneCheck")
	public boolean phoneCheck(@RequestParam String phone) {
		return memberService.checkPhoneExists(phone);
	}

	// 별명 중복 체크
	@ResponseBody
	@GetMapping("/register/nicknameCheck")
	public boolean nicknameCheck(@RequestParam String nickname) {
	    return memberService.checkNicknameExists(nickname);
	}


	// 로그아웃
	@GetMapping("/member/logout")
	public String logout(HttpSession session) {
		System.out.println("MemberController logout()");
		session.invalidate();
		return "redirect:/login";
	}

// ------------------------------------------------

	// 로그인 POST
	@PostMapping("/loginPro")
	public String loginPOST(MemberVO memberVO, HttpSession session, Model model, HttpServletRequest request,
			HttpServletResponse response) {

		System.out.println("MemberController loginPro()");
		System.out.println("memberVO : " + memberVO);

//쿠키 저장  시작------------------------------------------------------------------------------
		// 체크했으면 => 쿠키값 저장
		if (memberVO.getIdSave() != null) {
//			아이디값을 쿠키로 생성,사용 기간 설정, 사용자 컴퓨터에 파일로 저장
			Cookie cookie = new Cookie("cookid", memberVO.getUser_id());
			cookie.setMaxAge(30 * 60); // 30분, 1800초
			response.addCookie(cookie);
		}
		// 체크 해제 되어있으면 => 쿠키값 삭제
		if (memberVO.getIdSave() == null) {
			Cookie[] cookies = request.getCookies();
			// 쿠키값이 있으면
			if (cookies != null) {
				// 배열에서 쿠키값을 가져와서 반복
				for (Cookie cook : cookies) {
					// "cookid" 쿠키이름 찾기
					if (cook.getName().equals("cookid")) {
						// 쿠키값 삭제(시간 0, 사용자 컴퓨터에 저장(응답정보를 컴퓨터에 저장)
						cook.setMaxAge(0);
						response.addCookie(cook);
					}
				}
			}
		}
//쿠키 저장  끝------------------------------------------------------------------------------

		// 1.로그인 service -> db에서 로그인 결과값 받아오기 (일치하는 회원값)
		MemberVO resultVO = memberService.loginMember(memberVO);

		// 2. 세션에 사용자 정보 저장 -> 나중에 role = admin이면 navbar 변경해 주셔야 합니다
		if (resultVO != null) {
			session.setAttribute("user_id", resultVO.getUser_id());
			session.setAttribute("role", resultVO.getRole());
			session.setAttribute("nickname", resultVO.getNickname());

			// JSP에서 편하게 체크할 수 있도록 ${not empty sessionScope.loginUser} 체크
			session.setAttribute("loginUser", resultVO);
			if ("admin".equals(resultVO.getRole())) { // role이 'admin'이면
				return "redirect:/admin/dashboard"; // 관리자 대시보드로 이동
			} else {
				return "redirect:/main";
			}
		} else {

			// 로그인 실패 처리
			model.addAttribute("msg", "아이디 혹은 비밀번호가 일치하지 않습니다.");
			model.addAttribute("user_id", memberVO.getUser_id()); // ★ 사용자가 입력한 아이디 다시 전달
			return "/user/login";
		}
	}

}
