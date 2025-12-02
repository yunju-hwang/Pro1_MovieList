package com.itwillbs.controller;

import java.util.List;



import java.io.File;
import java.util.UUID;
import java.util.Map;
import java.util.HashMap;
import java.util.stream.Collectors;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


import com.google.gson.Gson;
import com.itwillbs.domain.MemberVO;
import com.itwillbs.domain.TheatersVO;
import com.itwillbs.domain.UserFavoritesVO;
import com.itwillbs.service.MypageService;

@Controller
public class MypageController {

	@Inject // 또는 @Autowired
	private MypageService mypageService;

	// 마이페이지 -> 관심 영화 목록
	@GetMapping("/mypage/favorites")
	public String getFavoriteMovies(HttpSession session, Model model) {
		// 1. 로그인된 사용자 정보 확인
		MemberVO user = (MemberVO) session.getAttribute("loginUser");

		if (user == null) {
			// 로그인되어 있지 않으면 로그인 페이지 등으로 리다이렉트
			return "redirect:/login";
		}

		String userId = user.getUser_id();

		// 2. Service를 호출하여 찜한 영화 목록 가져오기
		// UserFavoritesVO에는 tmdbId 외에 movie_title, poster_path가 함께 담겨 있습니다.
		List<UserFavoritesVO> favoriteList = mypageService.getFavoriteList(userId);

		Map<Integer, List<String>> genresMap = mypageService.getMovieGenresMap(favoriteList);

	    // 4. 목록과 맵을 JSP로 전달 (model에 추가)
	    model.addAttribute("favoriteList", favoriteList);
	    model.addAttribute("genresMap", genresMap); // 💡 이 코드가 반드시 있어야 합니다!

	    return "/mypage/favorites";
	}
	
	@DeleteMapping("/mypage/favorites/{tmdbId}")
	@ResponseBody
	public ResponseEntity<String> deleteFavoriteMovie(@PathVariable("tmdbId") int tmdbId, HttpSession session) {
		// 1. 로그인된 사용자 정보 확인
		MemberVO user = (MemberVO) session.getAttribute("loginUser");

		if (user == null) {
			// 로그인되어 있지 않으면 권한 없음 응답
			return new ResponseEntity<>("로그인이 필요합니다.", HttpStatus.UNAUTHORIZED);
		}

		String userId = user.getUser_id();

		// 2. Service를 호출하여 찜한 영화 삭제
		// 삭제할 정보: 사용자 ID와 영화 ID
		int result = mypageService.deleteFavoriteMovie(userId, tmdbId);

		// 3. 삭제 결과에 따른 응답 반환
		if (result > 0) {
			// 성공 시 200 OK
			return new ResponseEntity<>("관심 영화가 삭제되었습니다.", HttpStatus.OK);
		} else {
			// 실패 시 404 NOT FOUND 또는 500 INTERNAL SERVER ERROR
			return new ResponseEntity<>("삭제할 관심 영화를 찾을 수 없거나 DB 오류입니다.", HttpStatus.NOT_FOUND);
		}
	}
	
	
	
	

	// 마이페이지 -> 문의 목록
	@GetMapping("/mypage/inquiries")
	public String inquiries() {
		return "/mypage/inquiries";
	}	

	// 마이페이지 -> 영화 요청 목록
	@GetMapping("/mypage/movierequest")
	public String movieRequest() {
		return "/mypage/movie_request";
	}

	// 마이페이지 -> 회원정보수정
	@GetMapping("/mypage/profile")
	public String profile(HttpSession session, Model model) {

		MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");

		if (loginUser == null) {
			// 2-1. 로그인 정보가 없으면 로그인 페이지로 리다이렉트
			return "redirect:/login"; // 또는 다른 적절한 로그인 페이지 경로
		}

		String userId = loginUser.getUser_id();

		MemberVO memberInfoFromDB = mypageService.getMember(userId);

		if (memberInfoFromDB != null) {
			model.addAttribute("loginMember", memberInfoFromDB);
		} else {
			// (선택) DB에서 정보를 찾지 못한 경우 처리
			model.addAttribute("msg", "회원 정보를 찾을 수 없습니다.");
		}

		return "/mypage/profile";

	}
	
	@ResponseBody
	@PostMapping("/mypage/profile/checkPassword")
	public Map<String, Object> checkCurrentPassword(
	        @RequestParam("currentPassword") String currentPassword,
	        @SessionAttribute(value = "loginUser", required = false) MemberVO loginUser) { // loginUser 세션 사용
		System.out.println("DEBUG: currentPassword: " + currentPassword);
		if (loginUser != null) {
		    System.out.println("DEBUG: loginUser ID: " + loginUser.getUser_id());
		    System.out.println("DEBUG: loginUser Type: " + loginUser.getClass().getName());
		} else {
		    System.out.println("DEBUG: loginUser is NULL.");
		}
		
	    Map<String, Object> response = new HashMap<>();
	    
	    if (loginUser == null) {
	        response.put("isValid", false);
	        response.put("message", "로그인이 필요합니다.");
	        return response;
	    }
	    
	    String userId = loginUser.getUser_id();
	    
	    // DB에서 사용자 정보 조회 (평문 비밀번호 포함)
	    MemberVO memberInfo = mypageService.getMember(userId);
	    
	    if (memberInfo == null) {
	        response.put("isValid", false);
	        response.put("message", "회원 정보를 찾을 수 없습니다.");
	        return response;
	    }

	    // 🔑 핵심: DB의 평문 비밀번호와 입력된 비밀번호를 직접 비교
	    boolean isValid = memberInfo.getPassword().equals(currentPassword);
	    
	    response.put("isValid", isValid);
	    
	    if (!isValid) {
	        response.put("message", "비밀번호가 틀립니다.");
	    } else {
	    	response.put("message", "비밀번호 일치");
	    }
	    
	    return response; // { "isValid": true/false, "message": "..." } 형태로 JSON 반환
	}
	
	@PostMapping("/mypage/profile/update")
	public String updateMember(
	    MemberVO updateMember,
	    HttpSession session,
	    MultipartFile uploadFile, 
	    HttpServletRequest request,
	    RedirectAttributes rttr 
	) {
	    // 1. 로그인 여부 확인 및 userId 가져오기
	    MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");

	    if (loginUser == null) {
	        return "redirect:/login";  
	    }

	    String userId = loginUser.getUser_id();
	    updateMember.setUser_id(userId); 
	    
	    // =================================================================
	    // 🟢 파일 업로드 처리 로직 (기존 유지)
	    // =================================================================
	    
	    if (updateMember.getPassword() != null && updateMember.getPassword().isEmpty()) {
	        // 비밀번호를 변경하지 않는 경우, Mapper에서 UPDATE를 건너뛰도록 null로 설정
	        updateMember.setPassword(null);
	    }
	    
	    if (uploadFile != null && !uploadFile.isEmpty()) {
	        
	        // 🚨 [핵심 수정] 실제 소스 코드 폴더 경로를 직접 지정
	        String realPath = "D:" + File.separator + "JSP" + File.separator + "workspace_git" + File.separator 
	                          + "Pro1_MovieList" + File.separator + "src" + File.separator + "main" + File.separator 
	                          + "webapp" + File.separator + "resources" + File.separator + "upload";
	        
	        System.out.println("✅ Final Correct Path: " + realPath);
	        
	        File targetDir = new File(realPath);
	        if (!targetDir.exists()) {
	            targetDir.mkdirs();
	        }
	        
	        String originalFileName = uploadFile.getOriginalFilename();
	        String extension = originalFileName.substring(originalFileName.lastIndexOf("."));
	        String savedFileName = UUID.randomUUID().toString() + extension;
	        
	        File targetFile = new File(realPath, savedFileName);
	        
	        System.out.println("✅ Final Target File Path: " + targetFile.getAbsolutePath());
	        
	        try {
	            uploadFile.transferTo(targetFile);
	            
	            String webPath = "/resources/upload/" + savedFileName;
	            updateMember.setProfileImage(webPath);
	            
	        } catch (Exception e) {
	            System.err.println("파일 업로드 실패: " + e.getMessage());
	        }
	    } 
	    // =================================================================
	    // 🟢 파일 업로드 처리 로직 종료
	    // =================================================================

	    // =================================================================
	    // 🟢 핵심 수정: 필드별 중복 검사 및 메시지 조합
	    // =================================================================
	    StringBuilder errorFields = new StringBuilder();
	    boolean isDuplicate = false;

	    // 1. 닉네임 중복 검사
	    if (mypageService.checkDuplicateNicknameForUpdate(updateMember) > 0) {
	        errorFields.append("닉네임, ");
	        isDuplicate = true;
	    }

	    // 2. 이메일 중복 검사
	    if (mypageService.checkDuplicateEmailForUpdate(updateMember) > 0) {
	        errorFields.append("이메일, ");
	        isDuplicate = true;
	    }

	    // 3. 전화번호 중복 검사
	    if (mypageService.checkDuplicatePhoneForUpdate(updateMember) > 0) {
	        errorFields.append("전화번호, ");
	        isDuplicate = true;
	    }

	    if (isDuplicate) {
	        // 🚨 중복 발견! 오류 메시지 생성
	        
	        // 최종 메시지: "닉네임, 이메일, 전화번호이(가) 이미 사용 중입니다. 다른 값으로 수정해주세요."
	        String fieldList = errorFields.substring(0, errorFields.length() - 2); 
	        String finalErrorMsg = fieldList + "이(가) 이미 사용 중입니다.";
	        
	        rttr.addFlashAttribute("errorMsg", finalErrorMsg);
	        
	        return "redirect:/mypage/profile";
	    }
	    // =================================================================
	    // 🟢 중복 검사 로직 종료
	    // =================================================================

	    // 2. Service를 호출하여 DB 정보 업데이트 (중복이 없을 때만 실행)
	    int result = mypageService.updateMember(updateMember);

	    if (result > 0) {
	        // 3. DB 수정 성공 시, 세션 정보 갱신
	        MemberVO updatedInfo = mypageService.getMember(userId);
	        session.setAttribute("loginUser", updatedInfo); 
	        rttr.addFlashAttribute("msg", "회원 정보가 성공적으로 수정되었습니다.");
	    } else {
	        // DB 업데이트 실패 (예: 쿼리 오류 등)
	        rttr.addFlashAttribute("errorMsg", "데이터베이스 오류로 인해 회원 정보 수정에 실패했습니다.");
	    }

	    // 4. 회원 정보 조회 페이지로 다시 리다이렉트
	    return "redirect:/mypage/profile";
	}
	
	@ResponseBody
	@PostMapping("/mypage/profile/updatePassword")
	public Map<String, Object> updatePassword(
	    @RequestParam("newPassword") String newPassword,
	    @SessionAttribute(value = "loginUser", required = false) MemberVO loginUser) {

	    Map<String, Object> response = new HashMap<>();

	    if (loginUser == null) {
	        response.put("isUpdated", false);
	        response.put("message", "로그인이 필요합니다.");
	        return response;
	    }
	    
	    // 💡 1. 비밀번호 암호화 (필수!)
	    // BCryptPasswordEncoder 등을 사용하여 newPassword를 암호화해야 합니다.
	    String encryptedPassword = newPassword; // 🚨 실제 암호화 로직으로 교체해야 함

	    // 2. Service 호출
	    int result = mypageService.updatePassword(loginUser.getUser_id(), encryptedPassword);

	    if (result > 0) {
	        response.put("isUpdated", true);
	        response.put("message", "비밀번호가 성공적으로 변경되었습니다.");
	    } else {
	        response.put("isUpdated", false);
	        response.put("message", "DB 처리 중 오류가 발생했습니다.");
	    }

	    return response;
	}
	
	@PostMapping("/mypage/profile/withdrawal")
	@ResponseBody
	public Map<String, Object> withdrawal(HttpSession session) {
	    
	    Map<String, Object> response = new HashMap<>();
	    
	    // 1. 세션에서 로그인된 회원 정보(MemberVO)를 가져옴
	    MemberVO loginMember = (MemberVO) session.getAttribute("loginUser"); 

	    if (loginMember == null) {
	        response.put("isSuccess", false);
	        response.put("message", "세션이 만료되어 로그인이 필요합니다.");
	        return response;
	    }

	    // 🚨 [수정] 회원 번호(PK) 대신 user_id를 가져옴
	    // MemberVO 클래스에 getUser_id() 메서드가 있다고 가정합니다.
	    String userId = loginMember.getUser_id(); 

	    if (userId == null || userId.isEmpty()) {
	        response.put("isSuccess", false);
	        response.put("message", "회원 ID 정보를 가져올 수 없습니다.");
	        return response;
	    }

	    try {
	        // 2. Service 계층 호출: user_id를 인자로 전달하여 DB에서 회원 정보 삭제 처리
	        // MypageService에 deleteMember(String userId) 메서드가 구현될 예정입니다.
	        boolean isSuccess = mypageService.deleteMember(userId);

	        if (isSuccess) {
	            // 3. DB 삭제 성공 시: 세션 무효화 (로그아웃 처리)
	            session.invalidate(); 
	            response.put("isSuccess", true);
	            
	        } else {
	            response.put("isSuccess", false);
	            response.put("message", "회원 탈퇴 처리가 완료되지 않았습니다.");
	        }
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	        response.put("isSuccess", false);
	        response.put("message", "서버 처리 중 알 수 없는 오류가 발생했습니다.");
	    }

	    return response;
	}


	// 마이페이지 -> 영화 예약 조회
	@GetMapping("/mypage/reservations")
	public String reservations() {
		return "/mypage/reservations";
	}

	// 마이페이지 -> 선호 영화관 목록
	@GetMapping("/mypage/theaters")
	public String theaters(HttpSession session, Model model) {
		MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
		if (loginUser == null) {
	        return "redirect:/login"; 
	    }
	    String userId = loginUser.getUser_id();
	    
		List<TheatersVO> theaterList = mypageService.getTheaterList();
		
//		model.addAttribute("theaterList", theaterList);
		
		// List<VO> 객체를 JSON 문자열로 변환합니다.
	    String theaterListJson = new Gson().toJson(theaterList); 
	    
	    // Model에는 JSON 문자열 자체를 담습니다.
	    model.addAttribute("theaterListJson", theaterListJson);
	    
	    List<Integer> savedTheaterIds = mypageService.getSavedTheaterIds(userId);
	    String savedTheaterIdsJson = new Gson().toJson(savedTheaterIds);
	    model.addAttribute("savedTheaterIdsJson", savedTheaterIdsJson);

	    return "/mypage/theaters";
	}
	
	// 예시: MyPageController.java (수정된 메서드)

	@PostMapping("/mypage/theaters/update")
	public String updateTheaters(
	    @RequestParam(value = "theaterId", required = false) List<Integer> selectedTheaterIds,
	    // 📢 [삭제] @RequestParam(defaultValue = "false") boolean isAjaxDelete 파라미터를 제거합니다.
	    HttpSession session,
	    RedirectAttributes redirectAttributes) {

	    // 1. 사용자 ID 검증 (로그인 체크)
	    MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
	    if (loginUser == null) {
	        redirectAttributes.addFlashAttribute("errorMessage", "로그인이 필요합니다.");
	        return "redirect:/login"; 
	    }
	    String userId = loginUser.getUser_id();

	    // 📢 [AJAX 오류 방지 로직 삭제] isAjaxDelete가 없어졌으므로 관련 로직을 제거합니다.
	    // if (isAjaxDelete && (selectedTheaterIds == null || selectedTheaterIds.isEmpty())) { ... }

	    // 📢 [유지] selectedTheaterIds가 null이면 빈 리스트로 초기화합니다.
	    if (selectedTheaterIds == null) {
	        selectedTheaterIds = List.of();
	    }
	    
	    // 2. Service에 DB 처리 로직 위임 (전체 갱신)
	    try {
	        // 🎯 [핵심 변경] isAjaxDelete 파라미터를 제거하고 Service 메서드를 호출합니다.
	        mypageService.processTheaterUpdate(userId, selectedTheaterIds); 
	        
	        // 3. 응답 방식 (폼 제출이므로 항상 리다이렉트)
	        redirectAttributes.addFlashAttribute("successMessage", "선호 영화관 목록이 성공적으로 저장되었습니다.");
	        return "redirect:/mypage/theaters";
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	        
	        // 폼 제출 실패 시 처리
	        redirectAttributes.addFlashAttribute("errorMessage", "선호 영화관 저장 중 오류가 발생했습니다.");
	        return "redirect:/mypage/theaters";
	        
	        // 📢 [AJAX 실패 로직 삭제] isAjaxDelete 관련 catch 블록 로직을 제거합니다.
	    }
	}
	@PostMapping("/mypage/theaters/delete/ajax") // 새로운 AJAX 전용 주소
	@ResponseBody // 👈 여기에만 @ResponseBody 적용
	public String deleteTheaterAjax(
	    @RequestParam(value = "theaterId") int theaterId, // 단일 ID를 int로 받도록 명확히 합니다.
	    HttpSession session) {
	    
	    // 1. 사용자 ID 검증 (로그인 체크)
	    MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
	    if (loginUser == null) {
	        // AJAX 요청 실패 시 401 Unauthorized 상태 코드를 반환하는 것이 가장 좋으나, 
	        // 간단히 throw를 사용하여 500 오류를 유발하고 클라이언트가 처리하게 합니다.
	        throw new RuntimeException("로그인 세션이 만료되었습니다."); 
	    }
	    String userId = loginUser.getUser_id();
	    
	    try {
	        // Service에 단일 삭제 로직을 위한 별도의 메서드를 호출합니다.
	        // Service 로직 변경이 필요합니다! (아래 3단계 참고)
	        mypageService.deleteOneTheater(userId, theaterId); 
	        
	        return "ok"; // 200 OK 응답 본문에 "ok"를 담아 클라이언트에게 성공을 알립니다.
	    } catch (Exception e) {
	        e.printStackTrace();
	        // 500 Internal Server Error 발생 유도
	        throw new RuntimeException("선호 영화관 즉시 삭제 중 오류 발생", e); 
	    }
	}
	
	@GetMapping("/mypage/theaters/search")
	@ResponseBody // 반환 값을 HTTP 응답 본문에 JSON 형태로 직접 넣습니다.
	public List<TheatersVO> searchTheaters(@RequestParam("keyword") String keyword) {
	    // 키워드가 없거나 짧으면 검색하지 않고 빈 목록을 반환할 수 있습니다.
	    if (keyword == null || keyword.trim().isEmpty() || keyword.length() < 2) {
	        // Java 9+
	        return List.of(); 
	    }
	    
	    // Service를 통해 키워드를 포함하는 영화관 목록을 조회합니다.
	    return mypageService.searchTheatersByKeyword(keyword);
	}
	
	
	
	
}