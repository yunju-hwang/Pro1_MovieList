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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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

	// 마이페이지 -> 영화 예약 조회
	@GetMapping("/mypage/reservations")
	public String reservations() {
		return "/mypage/reservations";
	}

	// 마이페이지 -> 선호 영화관 목록
	@GetMapping("/mypage/theaters")
	public String theaters(HttpSession session, Model model) {
		List<TheatersVO> theaterList = mypageService.getTheaterList();
		
		model.addAttribute("theaterList", theaterList);
		
	    return "/mypage/theaters";
	}
	
	
	
}
