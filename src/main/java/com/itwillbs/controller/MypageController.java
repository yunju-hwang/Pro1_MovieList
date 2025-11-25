package com.itwillbs.controller;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
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
	
	@PostMapping("/mypage/profile/update")
	public String updateMember(MemberVO updateMember, HttpSession session) {
	        // 1. 로그인 여부 확인 및 userId 가져오기
	        MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");

	        if (loginUser == null) {
	            // 로그인 정보가 없으면 로그인 페이지로 리다이렉트 (보안)
	            return "redirect:/login"; 
	        }

	        // 2. 수정 대상 userId를 VO에 설정 (로그인된 사용자의 ID 사용)
	        String userId = loginUser.getUser_id();
	        updateMember.setUser_id(userId); 
	        
	        // **중요: 비밀번호는 여기서 수정하지 않고, 별도 페이지에서 처리해야 합니다.**
	        // updateMember 객체에는 사용자가 수정하려는 이메일, 생년월일, 성별, 전화번호 등이 담겨 있습니다.

	        // 3. Service를 호출하여 DB 정보 업데이트
	        int result = mypageService.updateMember(updateMember); // DB 업데이트 로직 호출

	        if (result > 0) {
	            // 4. DB 수정 성공 시, 세션 정보 갱신
	            // 최신 정보를 다시 조회하여 세션을 갱신합니다.
	            MemberVO updatedInfo = mypageService.getMember(userId);
	            session.setAttribute("loginUser", updatedInfo); 
	            
	            // 메시지 관련 로직이 사라졌습니다.
	        }

	        // 6. 회원 정보 조회 페이지로 다시 리다이렉트
	        return "redirect:/mypage/profile";
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
	
	@PostMapping("/mypage/theaters/update")
	public String updateTheaters(
	    // 📢 [수정]: required = false를 추가하여 파라미터가 전송되지 않아도 오류가 나지 않게 함.
	    @RequestParam(value = "theaterId", required = false) List<Integer> selectedTheaterIds,
	    HttpSession session,
	    RedirectAttributes redirectAttributes) {

	    // 1. 사용자 ID 검증 (로그인 체크)
	    MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
	    if (loginUser == null) {
	        redirectAttributes.addFlashAttribute("errorMessage", "로그인이 필요합니다.");
	        return "redirect:/login"; 
	    }
	    String userId = loginUser.getUser_id();

	    // 📢 [추가 로직]: 파라미터가 전송되지 않아 null로 넘어온 경우, 빈 리스트로 초기화합니다.
	    if (selectedTheaterIds == null) {
	        // List.of()는 Java 9 이상에서 사용 가능하며, 불변(immutable) 빈 리스트를 만듭니다.
	        // Java 8 이하를 사용 중이라면: selectedTheaterIds = new java.util.ArrayList<>(); 를 사용하세요.
	        selectedTheaterIds = List.of(); 
	    }

	    // 2. Service에 DB 저장 로직 위임
	    try {
	        // selectedTheaterIds가 빈 리스트(0개)인 경우, Service는 해당 사용자의 
	        // 기존 선호 영화관을 모두 삭제(DELETE) 처리하게 됩니다.
	        mypageService.saveUserTheaters(userId, selectedTheaterIds); 
	        
	        redirectAttributes.addFlashAttribute("successMessage", "선호 영화관 목록이 성공적으로 저장되었습니다.");
	    } catch (Exception e) {
	        e.printStackTrace(); 
	        redirectAttributes.addFlashAttribute("errorMessage", "선호 영화관 저장 중 오류가 발생했습니다.");
	    }

	    // 3. 처리가 완료되면 마이페이지/영화관 설정 화면으로 리다이렉트
	    return "redirect:/mypage/theaters"; 
	}
	
	
	
}