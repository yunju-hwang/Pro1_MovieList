package com.itwillbs.scheduler;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.itwillbs.service.MovieService;
@Component
public class MovieScheduler {
	private final MovieService movieService;
	
	public MovieScheduler(MovieService movieService) {
		this.movieService = movieService;
	}
	
	// 매일 새벽 2시에 영화 업데이트
	@Scheduled(cron = "0 0 2 * * ?")
	public void dailyUpdateMovies() {
		 try {
	           movieService.getPopularMovies(); // TMDB API 호출 + DB 저장
	     } catch (Exception e) {
	           e.printStackTrace();
	     }
	}
	
	
}
